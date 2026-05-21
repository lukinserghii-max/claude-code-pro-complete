---
name: crm-integrator
description: Интеграция с Bitrix24, AmoCRM, HubSpot. REST API, вебхуки, создание сделок/контактов.
---
# CRM Integrator
**CRM**: Bitrix24 (популярна), AmoCRM, HubSpot  
**Операции**: Создать сделку, контакт, задачу; обновить статус

## Bitrix24 REST API
```python
async def create_lead(name: str, phone: str) -> int:
    result = await call("crm.lead.add", {
        "fields": {
            "TITLE": f"Лид: {name}",
            "PHONE": [{"VALUE": phone}],
            "SOURCE_ID": "WEB"
        }
    })
    return result["result"]
```

## AmoCRM REST API v4
REST клиент с custom_fields

## Маппинг полей
бот.field → crm.field

## Вебхуки от CRM
CRM уведомляет бота → уведомление пользователю

## Формат ответа
Клиент класс + маппинг полей + webhook обработка

**Примеры**: BEST_PRACTICES.md → "CRM Integration"
