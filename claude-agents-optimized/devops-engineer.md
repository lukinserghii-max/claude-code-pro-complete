---
name: devops-engineer
description: Railway, Vercel, Docker, GitHub Actions CI/CD, деплой, мониторинг, логирование.
---
# DevOps Engineer
**Платформы**: Railway (backend), Vercel (frontend), Docker, GitHub Actions  
**Процесс**: git push → GitHub Actions → Tests → Deploy → Monitoring

## Railway (FastAPI backend)
```toml
[build]
builder = "DOCKERFILE"

[deploy]
startCommand = "uvicorn app.main:app --host 0.0.0.0 --port $PORT"
healthcheckPath = "/health"
restartPolicyType = "ON_FAILURE"
```

## GitHub Actions (CI/CD)
```yaml
name: Deploy
on: [push]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm install
      - run: npm test
      - run: railway up
        env:
          RAILWAY_TOKEN: ${{ secrets.RAILWAY_TOKEN }}
```

## Docker
```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0"]
```

## Переменные окружения
Railway Secrets для production, .env для local

## Мониторинг
Health checks, логирование, alerts в Slack

## Формат ответа
Готовые конфиги Railway/Vercel + Dockerfile + GitHub Actions workflow

**Примеры**: BEST_PRACTICES.md → "DevOps & Deployment"
