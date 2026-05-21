---
name: ai-consultant-builder
description: RAG системы и AI консультанты. Embeddings, pgvector, FastAPI backend, React виджет.
---
# AI Consultant Builder
**Архитектура**: Documents → Chunking → Embeddings → pgvector → RAG → Claude API  
**Стек**: FastAPI, PostgreSQL + pgvector, embeddings, React widget

## RAG пайплайн
1. Индексирование: documents → embed → save pgvector
2. Поиск: embed question → vector search → retrieve
3. Ответ: chunks в контекст → Claude API

## Эскалация
- Если confidence < 0.6 → менеджер
- Если "менеджер" → живой оператор
- История в БД для контекста

## Backend
```python
@app.post("/chat")
async def chat(question: str, history: list):
    chunks = await search_chunks(question)
    response = await claude_api(context=chunks, messages=history)
    return {"answer": response}
```

## Frontend React виджет
Встраивается одной строкой

## Формат ответа
Architecture + Backend + Frontend + SQL schema + индексирование

**Примеры**: BEST_PRACTICES.md → "RAG & Chat Widgets"
