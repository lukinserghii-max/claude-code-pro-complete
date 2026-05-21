# Задание для Claude Code: Установка Claude Code Pro Complete

## Цель
Установить все компоненты Claude Code Pro на эту машину и создать публичный GitHub репозиторий `claude-code-pro-complete`.

## Данные
- GitHub user: `sergeylkn`
- GitHub token: `YOUR_GITHUB_TOKEN`
- Repo name: `claude-code-pro-complete`
- Архив с агентами: `~/Downloads/claude-agents-optimized.tar.gz`
- Установщик MCP: `~/Downloads/install-all-claude-code.sh`

## Шаги выполнения

### 1. Проверить зависимости
- Проверь что установлены: `git`, `node`, `npm`, `curl`
- Если чего-то нет — сообщи пользователю что нужно установить

### 2. Установить Claude Code (если нет)
```bash
npm install -g @anthropic-ai/claude-code
```

### 3. Создать директории
```bash
mkdir -p ~/.claude/agents
mkdir -p ~/.claude/skills  
mkdir -p ~/.claude/plugins
mkdir -p ~/claude-code-pro-complete
```

### 4. Распаковать агентов
```bash
cd ~/claude-code-pro-complete
tar -xzf ~/Downloads/claude-agents-optimized.tar.gz
cp claude-agents-optimized/*.md ~/.claude/agents/
```

### 5. Создать GitHub репозиторий
```bash
curl -s -X POST \
  -H "Authorization: token YOUR_GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  -d '{"name":"claude-code-pro-complete","description":"🚀 88+ компонентов для Claude Code — 32 агента, 40+ скилов, 10 MCP серверов. Из лучших GitHub репо (421k+ ⭐)","private":false,"has_issues":true}' \
  https://api.github.com/user/repos
```

### 6. Загрузить файлы на GitHub
```bash
cd ~/claude-code-pro-complete
git init
git config user.email "sergeylkn@users.noreply.github.com"
git config user.name "sergeylkn"
git add .
git commit -m "🚀 Initial commit: Claude Code Pro Complete — 32 agents, 40+ skills, 10 MCP servers"
git branch -M main
git remote add origin https://sergeylkn:YOUR_GITHUB_TOKEN@github.com/sergeylkn/claude-code-pro-complete.git
git push -u origin main
```

### 7. Запустить установщик MCP серверов
```bash
cd ~/Downloads
chmod +x install-all-claude-code.sh
bash install-all-claude-code.sh
```

### 8. Создать ~/.claude/CLAUDE.md
Если файл не существует, создай его с базовым профилем:
```
# Claude Code Pro — Sergey's Setup

## Stack
- Backend: Python (FastAPI), Node.js
- Frontend: Next.js 15, React, Tailwind
- DB: PostgreSQL + pgvector, Supabase
- Automation: n8n (rew.app.n8n.cloud), Make.com
- Deploy: Railway, Vercel, Docker
- Bots: Telegram (aiogram 3.x)
- AI: Claude API, fal.ai, Runway ML
- Storage: Cloudinary

## Rules
- Комментарии в коде на русском
- Всегда .env для секретов
- Всегда Dockerfile
- Типизация везде (TypeScript/Python type hints)
- Логирование через loguru (Python) или winston (Node)
```

### 9. Проверить результат
После установки выведи итоговую статистику:
- Сколько агентов установлено (`ls ~/.claude/agents/*.md | wc -l`)
- Ссылку на GitHub репозиторий
- Что Claude Code готов к работе

## Обработка ошибок
- Если репо уже существует — пропусти создание, только push
- Если архив не найден в Downloads — проверь ~/Desktop и ~/Documents
- Если нет прав на папку — используй sudo только для npm install
- После каждого шага выводи статус ✅ или ❌ с пояснением

## Ожидаемый результат
```
✅ Зависимости: OK
✅ Claude Code: установлен
✅ Директории: созданы
✅ Агентов установлено: 32
✅ GitHub репо: https://github.com/sergeylkn/claude-code-pro-complete
✅ MCP серверы: установлены
✅ CLAUDE.md: создан
🎉 Всё готово! Запусти: claude
```
