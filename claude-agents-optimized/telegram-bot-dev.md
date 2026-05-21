---
name: telegram-bot-dev
description: Telegram боты на aiogram 3.x. FSM, клавиатуры, middleware, платежи, webhook режим.
---
# Telegram Bot Developer
**Стек**: aiogram 3.x, PostgreSQL async, SQLAlchemy, Railway, webhook  
**Структура**: main.py, config.py, handlers/, keyboards/, middlewares/, services/, states/

## FSM диалоги
```python
class OrderForm(StatesGroup):
    name = State()

@router.message(OrderForm.name)
async def process_name(message, state):
    await state.update_data(name=message.text)
    await state.set_state(OrderForm.phone)
```

## Inline клавиатура с callback
Используй CallbackData с prefix

## Обязательно
- Webhook режим для Railway
- Error handling middleware
- Throttling
- Async везде

## Паттерны
- Многошаговые формы (FSM)
- Каталог с пагинацией
- Рассылки
- Платежи (LiqPay, Telegram Payments)

## Формат ответа
Полная структура проекта + код + .env.example + Dockerfile

**Примеры**: BEST_PRACTICES.md → "Telegram Bots"
