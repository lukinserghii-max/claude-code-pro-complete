---
name: make-builder
description: Создаёт сценарии Make.com. Модули, фильтры, роутеры, автоматизация бизнеса.
---
# Make.com Builder
**Навык**: Сценарии Make для интеграции готовых сервисов  
**Stack**: Make.com, 1000+ модули (Zapier, Airtable, Slack, Email, HTTP)  
**Лучше для**: Простые интеграции, no-code автоматизация

## Структура сценария
- **Watch** (Webhook, Schedule, App trigger) → **Router** → **Filter** на каждой ветке → **Action** модули
- **Error handler** при ошибке
- **Data mapper** для преобразования полей

## Обязательно
- Использовать Text Parser для разбора сложных строк
- Iterator + Array Aggregator для массивов
- Sleep модуль при rate limits
- Фильтры после роутера (если ветвятся)

## Часто используемые модули
- HTTP, Webhooks, Slack, Email, Google Sheets, Stripe, CRM, Telegram

## Формат ответа
Описание + детально каждый шаг сценария + список Connections

**Примеры**: BEST_PRACTICES.md → "Workflow Automation"
