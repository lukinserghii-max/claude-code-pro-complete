# 📚 BEST PRACTICES — Примеры, паттерны, детали

**Этот файл** содержит все подробные примеры, паттерны и код, которые не загружаются с каждым агентом. Экономит ~80% токенов!

---

## 🔧 PYTHON РАЗРАБОТКА

### FastAPI + PostgreSQL полный пример

```python
# main.py
from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from contextlib import asynccontextmanager

app = FastAPI()

# Database
engine = create_async_engine("postgresql+asyncpg://...")
AsyncSessionLocal = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)

async def get_db():
    async with AsyncSessionLocal() as session:
        yield session

# API
@app.post("/users/")
async def create_user(user: UserCreate, db: AsyncSession = Depends(get_db)):
    db_user = User(**user.dict())
    db.add(db_user)
    await db.commit()
    await db.refresh(db_user)
    return db_user

# Config
class Settings(BaseSettings):
    database_url: str
    secret_key: str
    class Config:
        env_file = ".env"

settings = Settings()
```

### Aiogram 3.x FSM форма

```python
from aiogram import Router, F
from aiogram.fsm.context import FSMContext
from aiogram.fsm.state import State, StatesGroup

class OrderForm(StatesGroup):
    name = State()
    phone = State()
    address = State()

router = Router()

@router.message(Command("order"))
async def start_order(message: Message, state: FSMContext):
    await message.answer("Как вас зовут?")
    await state.set_state(OrderForm.name)

@router.message(OrderForm.name)
async def process_name(message: Message, state: FSMContext):
    await state.update_data(name=message.text)
    await message.answer("Ваш телефон?")
    await state.set_state(OrderForm.phone)

@router.message(OrderForm.phone)
async def process_phone(message: Message, state: FSMContext):
    data = await state.get_data()
    # Сохрани в БД
    await state.clear()
    await message.answer("✅ Заявка принята!")
```

### Обработка ошибок

```python
from loguru import logger
import traceback

@app.exception_handler(Exception)
async def global_exception_handler(request, exc):
    logger.error(f"Unhandled exception: {exc}\n{traceback.format_exc()}")
    return JSONResponse(status_code=500, content={"detail": "Internal server error"})

# При работе с БД
try:
    async with AsyncSessionLocal() as session:
        result = await session.execute(query)
except SQLAlchemyError as e:
    logger.error(f"Database error: {e}")
    raise HTTPException(status_code=500, detail="Database error")
```

---

## 🌐 FRONTEND (Next.js + React)

### Chat виджет

```typescript
'use client'
import { useState } from 'react'

export function ChatWidget({ apiUrl }: { apiUrl: string }) {
  const [messages, setMessages] = useState<{role: string, content: string}[]>([])
  const [input, setInput] = useState('')
  const [loading, setLoading] = useState(false)

  const sendMessage = async () => {
    if (!input.trim() || loading) return
    setMessages(prev => [...prev, { role: 'user', content: input }])
    setInput('')
    setLoading(true)

    try {
      const res = await fetch(`${apiUrl}/chat`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ question: input, history: messages })
      })
      const data = await res.json()
      setMessages(prev => [...prev, { role: 'assistant', content: data.answer }])
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="fixed bottom-4 right-4 w-96 bg-white rounded-lg shadow-2xl border">
      <div className="p-4 bg-blue-600 text-white rounded-t-lg">
        <h3 className="font-semibold">AI Консультант</h3>
      </div>
      <div className="h-80 overflow-y-auto p-4 space-y-3">
        {messages.map((m, i) => (
          <div key={i} className={`p-3 rounded text-sm ${
            m.role === 'user' ? 'bg-blue-50 ml-8' : 'bg-gray-50 mr-8'
          }`}>
            {m.content}
          </div>
        ))}
      </div>
      <div className="p-4 flex gap-2 border-t">
        <input
          value={input}
          onChange={e => setInput(e.target.value)}
          onKeyDown={e => e.key === 'Enter' && sendMessage()}
          className="flex-1 border rounded px-3 py-2 text-sm"
          placeholder="Ваш вопрос..."
        />
        <button onClick={sendMessage} className="bg-blue-600 text-white px-4 py-2 rounded text-sm">
          →
        </button>
      </div>
    </div>
  )
}
```

### Next.js API route

```typescript
// app/api/chat/route.ts
import { NextRequest, NextResponse } from 'next/server'

export async function POST(request: NextRequest) {
  try {
    const { question, history } = await request.json()
    
    // Вызвать Claude API или RAG
    const response = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': process.env.ANTHROPIC_API_KEY!
      },
      body: JSON.stringify({
        model: 'claude-sonnet-4-20250514',
        max_tokens: 1000,
        messages: [...history, { role: 'user', content: question }]
      })
    })

    const data = await response.json()
    return NextResponse.json({ answer: data.content[0].text })
  } catch (error) {
    return NextResponse.json({ error: 'Failed to process' }, { status: 500 })
  }
}
```

---

## 🤖 N8N WORKFLOWS

### Webhook → Обработка → CRM

```json
{
  "nodes": [
    {
      "name": "Webhook",
      "type": "n8n-nodes-base.webhook",
      "typeVersion": 1,
      "position": [250, 300],
      "webhookId": "webhook-id",
      "webhookUrl": "https://n8n.instance.com/webhook/webhook-id"
    },
    {
      "name": "Validate Data",
      "type": "n8n-nodes-base.if",
      "position": [450, 300],
      "parameters": {
        "conditions": {
          "string": [
            {
              "value1": "{{ $json.phone }}",
              "operation": "exists"
            }
          ]
        }
      }
    },
    {
      "name": "Create Lead in Bitrix24",
      "type": "n8n-nodes-base.bitrix24",
      "position": [650, 300],
      "parameters": {
        "resource": "lead",
        "operation": "create",
        "title": "{{ $json.name }}",
        "phone": "{{ $json.phone }}",
        "email": "{{ $json.email }}"
      }
    }
  ],
  "connections": {
    "Webhook": { "main": [[ { "node": "Validate Data", "branch": 0 } ]] },
    "Validate Data": { "main": [[ { "node": "Create Lead in Bitrix24", "branch": 0 } ]] }
  }
}
```

---

## 📱 TELEGRAM БОТЫ

### Inline клавиатура с callback

```python
from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton
from aiogram.filters.callback_data import CallbackData

class ProductCallback(CallbackData, prefix="product"):
    id: int
    action: str  # "view", "buy", "add_to_cart"

def get_product_keyboard(product_id: int) -> InlineKeyboardMarkup:
    return InlineKeyboardMarkup(inline_keyboard=[[
        InlineKeyboardButton(
            text="🛍️ Купить",
            callback_data=ProductCallback(id=product_id, action="buy").pack()
        ),
        InlineKeyboardButton(
            text="ℹ️ Подробнее",
            callback_data=ProductCallback(id=product_id, action="view").pack()
        )
    ]])

@router.callback_query(ProductCallback.filter())
async def process_product_callback(query: CallbackQuery, callback_data: ProductCallback):
    if callback_data.action == "buy":
        # Обработка покупки
        pass
```

### Рассылка по базе пользователей

```python
async def broadcast_to_users(message_text: str, user_ids: list[int]):
    failed = 0
    for user_id in user_ids:
        try:
            await bot.send_message(user_id, message_text)
            await asyncio.sleep(0.05)  # Избегаем rate limit
        except TelegramBadRequest:
            failed += 1
            # Пользователь заблокировал бота или он удален
    
    logger.info(f"Рассыпка: отправлено {len(user_ids) - failed}, ошибок {failed}")
```

---

## 💾 БАЗА ДАННЫХ

### PostgreSQL + pgvector (для RAG)

```python
from sqlalchemy import Column, Integer, String, Text, DateTime, Index
from pgvector.sqlalchemy import Vector

class KnowledgeChunk(Base):
    __tablename__ = "knowledge_chunks"
    
    id = Column(Integer, primary_key=True)
    content = Column(Text, nullable=False)
    embedding = Column(Vector(1536), nullable=False)  # OpenAI embeddings
    source = Column(String, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    
    __table_args__ = (
        Index('idx_embedding', embedding, postgresql_using="ivfflat", postgresql_with={"lists": 100}),
    )

# RAG поиск
async def search_relevant_chunks(query_embedding: list[float], limit: int = 5) -> list[str]:
    async with AsyncSessionLocal() as session:
        result = await session.execute(
            select(KnowledgeChunk.content)
            .order_by(KnowledgeChunk.embedding.cosine_distance(query_embedding))
            .limit(limit)
        )
        return [row[0] for row in result.fetchall()]
```

---

## 🚀 DEVOPS

### Dockerfile для FastAPI

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

### GitHub Actions CI/CD

```yaml
name: Deploy to Railway
on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install Railway
        run: npm i -g @railway/cli
      - name: Deploy
        run: railway up
        env:
          RAILWAY_TOKEN: ${{ secrets.RAILWAY_TOKEN }}
```

### Railway deployment config

```toml
[build]
builder = "DOCKERFILE"

[deploy]
startCommand = "uvicorn app.main:app --host 0.0.0.0 --port $PORT"
healthcheckPath = "/health"
restartPolicyType = "ON_FAILURE"
restartPolicyMaxRetries = 3
```

---

## 📊 АНАЛИТИКА И CRM

### BANT квалификация в коде

```python
BANT_SCORES = {
    "budget": {"есть": 25, "уточняем": 15, "нет": 0},
    "authority": {"руководитель": 25, "влияет": 15, "исполнитель": 5},
    "need": {"срочная": 25, "есть": 15, "не понятна": 0},
    "timeline": {"до месяца": 25, "квартал": 15, "6+ месяцев": 5}
}

def calculate_lead_score(answers: dict) -> tuple[int, str]:
    total = sum(BANT_SCORES[key].get(answers[key], 0) for key in answers)
    if total >= 80:
        return total, "HOT"
    elif total >= 50:
        return total, "WARM"
    else:
        return total, "COLD"
```

---

## 🎨 КОНТЕНТ

### Генерация изображения через fal.ai

```python
import httpx

async def generate_image(prompt: str) -> str:
    async with httpx.AsyncClient() as client:
        response = await client.post(
            "https://fal.run/fal-ai/flux/schnell",
            headers={"Authorization": f"Key {FAL_KEY}"},
            json={
                "prompt": prompt,
                "image_size": "landscape_4_3",
                "num_images": 1
            },
            timeout=60
        )
        result = response.json()
        return result["images"][0]["url"]

# Использование
url = await generate_image("Professional product photo of hydraulic hose")
```

### Runway ML видео генерация

```python
async def generate_video(prompt: str, image_url: str = None) -> str:
    """Генерирует видео через Runway Gen-3"""
    async with httpx.AsyncClient() as client:
        payload = {
            "model": "gen3a_turbo",
            "promptText": prompt,
            "duration": 4,
            "ratio": "16:9"
        }
        if image_url:
            payload["promptImage"] = image_url
        
        response = await client.post(
            "https://api.dev.runwayml.com/v1/image_to_video",
            headers={"Authorization": f"Bearer {RUNWAY_KEY}"},
            json=payload
        )
        task = response.json()
        
        # Ждём результат
        task_id = task["id"]
        while True:
            status = await client.get(
                f"https://api.dev.runwayml.com/v1/tasks/{task_id}",
                headers={"Authorization": f"Bearer {RUNWAY_KEY}"}
            )
            if status.json()["status"] == "SUCCEEDED":
                return status.json()["output"][0]
            await asyncio.sleep(5)
```

---

## 🔐 БЕЗОПАСНОСТЬ

### Защита от SQL injection

```python
# ❌ НЕПРАВИЛЬНО (уязвимо)
query = f"SELECT * FROM users WHERE id = {user_id}"

# ✅ ПРАВИЛЬНО (защищено)
query = select(User).where(User.id == user_id)
# SQLAlchemy автоматически экранирует

# Для raw SQL
from sqlalchemy import text
query = select(User).from_statement(
    text("SELECT * FROM users WHERE id = :id")
).bindparams(id=user_id)
```

### Rate limiting

```python
from slowapi import Limiter
from slowapi.util import get_remote_address

limiter = Limiter(key_func=get_remote_address)
app.state.limiter = limiter

@app.post("/api/chat", dependencies=[Depends(limiter.limit("5/minute"))])
async def chat(message: str):
    # Максимум 5 запросов в минуту
    return {"response": "..."}
```

### JWT безопасность

```python
from jose import JWTError, jwt
from datetime import datetime, timedelta

SECRET_KEY = "твой-секретный-ключ"
ALGORITHM = "HS256"

def create_access_token(data: dict):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(hours=24)
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

async def verify_token(token: str):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        user_id = payload.get("sub")
        if user_id is None:
            raise HTTPException(status_code=401)
        return user_id
    except JWTError:
        raise HTTPException(status_code=401)
```

---

## 📧 EMAIL И МАРКЕТИНГ

### Email через SendGrid

```python
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail

def send_welcome_email(email: str, name: str):
    message = Mail(
        from_email='noreply@example.com',
        to_emails=email,
        subject='Добро пожаловать!',
        html_content=f'<h1>Привет, {name}!</h1><p>Спасибо за регистрацию.</p>'
    )
    
    sg = SendGridAPIClient(os.environ.get('SENDGRID_API_KEY'))
    response = sg.send(message)
    return response.status_code == 202
```

---

## 🧪 ТЕСТИРОВАНИЕ

### Pytest для FastAPI

```python
from fastapi.testclient import TestClient
import pytest

client = TestClient(app)

@pytest.fixture
def sample_user():
    return {"name": "John", "email": "john@example.com"}

def test_create_user(sample_user):
    response = client.post("/users/", json=sample_user)
    assert response.status_code == 201
    assert response.json()["name"] == "John"

def test_get_user():
    response = client.get("/users/1")
    assert response.status_code == 200
```

### Playwright для фронтенда

```python
from playwright.async_api import async_playwright

async def test_chat_widget():
    async with async_playwright() as p:
        browser = await p.chromium.launch()
        page = await browser.new_page()
        
        await page.goto("http://localhost:3000")
        await page.fill('[placeholder="Ваш вопрос..."]', "Привет")
        await page.click('button:has-text("→")')
        
        # Ждем ответа
        await page.wait_for_selector('[role="status"]')
        assert "Привет" in await page.content()
        
        await browser.close()
```

---

**Используй эти примеры когда нужны детали. Каждый агент ссылается на этот файл вместо дублирования!**
