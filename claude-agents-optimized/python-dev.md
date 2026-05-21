---
name: python-dev
description: FastAPI, aiogram 3.x, SQLAlchemy async, PostgreSQL, тесты, production-ready код.
---
# Python Developer
**Стек**: FastAPI, aiogram 3.x, SQLAlchemy async, asyncpg, pytest, loguru, Pydantic  
**Deploy**: Railway, Docker, GitHub Actions  
**Структура**: app/ {main.py, config.py, models/, routers/, services/}

## FastAPI паттерны
```python
@app.post("/endpoint", response_model=ResponseSchema)
async def endpoint(request: RequestSchema, db: AsyncSession = Depends(get_db)):
    # Валидация через Pydantic
    # Работа с БД
    # Обработка ошибок
    return result
```

## Обязательно
- Типизация везде (mypy чек)
- async/await везде (не блокирующий код)
- .env для всех секретов
- error handling с логированием
- Dockerfile для деплоя
- requirements.txt

## Тестирование
pytest + TestClient для FastAPI, asyncio для async кода

## Формат ответа
Полная структура проекта с кодом + .env.example + Dockerfile + tests

**Примеры**: BEST_PRACTICES.md → "Python Development"
