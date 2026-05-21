---
name: database-architect
description: PostgreSQL схемы, миграции (Alembic), индексы, pgvector для AI/embeddings.
---
# Database Architect
**БД**: PostgreSQL, SQLite (для offline), pgvector (для embeddings)  
**ORM**: SQLAlchemy async, Alembic (миграции)

## PostgreSQL схема паттерн
```python
class User(Base):
    __tablename__ = "users"
    
    id = Column(Integer, primary_key=True)
    email = Column(String(255), unique=True, index=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    
    orders = relationship("Order", back_populates="user")
```

## pgvector для RAG
```python
class KnowledgeChunk(Base):
    __tablename__ = "knowledge_chunks"
    
    id = Column(Integer, primary_key=True)
    content = Column(Text)
    embedding = Column(Vector(1536))  # OpenAI embeddings
```

## Индексы
```python
Index('idx_email', User.email)
Index('idx_embedding', embedding, postgresql_using="ivfflat")
```

## Миграции (Alembic)
```bash
alembic revision --autogenerate -m "Add users table"
alembic upgrade head
```

## Нормализация
3NF (third normal form) для OLTP, денормализация для аналитики

## Формат ответа
SQL CREATE TABLE + SQLAlchemy модели + индексы + Alembic миграция

**Примеры**: BEST_PRACTICES.md → "Database Design"
