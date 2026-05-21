#!/usr/bin/env bash
# ============================================================
# Claude Code — полный установщик MCP серверов
# Стек: n8n, Make, Telegram боты, AI консультанты, Видео/Фото
# ============================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

log()    { echo -e "${GREEN}✓${NC} $1"; }
warn()   { echo -e "${YELLOW}⚠${NC}  $1"; }
info()   { echo -e "${CYAN}→${NC} $1"; }
header() { echo -e "\n${BLUE}══════════════════════════════════════${NC}"; echo -e "${BLUE}  $1${NC}"; echo -e "${BLUE}══════════════════════════════════════${NC}"; }
fail()   { echo -e "${RED}✗${NC} $1"; }

# ── Переменные — заполни перед запуском ─────────────────────
BRAVE_API_KEY=""          # https://api.search.brave.com → Free tier: 2000 req/mo
N8N_URL=""                # https://твой.app.n8n.cloud  (если self-hosted с MCP)
TELEGRAM_BOT_TOKEN=""     # https://t.me/BotFather → /newbot
SUPABASE_URL=""           # https://supabase.com → Settings → API
SUPABASE_KEY=""           # Service role key
PROJECTS_DIR="$HOME/projects"   # Где хранятся твои проекты
# ────────────────────────────────────────────────────────────

header "1. Проверка зависимостей"

# Node.js
if command -v node &>/dev/null; then
    NODE_VER=$(node --version)
    log "Node.js $NODE_VER"
else
    fail "Node.js не найден!"
    info "Установи с https://nodejs.org (нужна v18+)"
    exit 1
fi

# npm
if command -v npm &>/dev/null; then
    log "npm $(npm --version)"
else
    fail "npm не найден"
    exit 1
fi

# Claude Code
if command -v claude &>/dev/null; then
    log "Claude Code $(claude --version 2>/dev/null | head -1)"
else
    warn "Claude Code не найден — устанавливаю..."
    npm install -g @anthropic-ai/claude-code
    log "Claude Code установлен"
fi

header "2. Создание директорий"

mkdir -p ~/.claude
mkdir -p "$PROJECTS_DIR"
log "Директории готовы"

header "3. Установка MCP серверов"

# ── 3.1 Filesystem ──────────────────────────────────────────
info "Filesystem MCP (доступ к файлам проектов)..."
claude mcp add filesystem \
    --scope user \
    --transport stdio \
    -- npx -y @modelcontextprotocol/server-filesystem \
    "$PROJECTS_DIR" "$HOME/Downloads" && log "Filesystem MCP ✓" || warn "Filesystem MCP — ошибка, пропускаю"

# ── 3.2 Playwright ──────────────────────────────────────────
info "Playwright MCP (браузерная автоматизация, тестирование ботов)..."
claude mcp add playwright \
    --scope user \
    --transport stdio \
    -- npx -y @playwright/mcp@latest && log "Playwright MCP ✓" || warn "Playwright MCP — ошибка, пропускаю"

# ── 3.3 Brave Search ────────────────────────────────────────
if [ -n "$BRAVE_API_KEY" ]; then
    info "Brave Search MCP (веб-поиск для AI агентов)..."
    claude mcp add brave-search \
        --scope user \
        --transport stdio \
        -e BRAVE_API_KEY="$BRAVE_API_KEY" \
        -- npx -y @modelcontextprotocol/server-brave-search && log "Brave Search MCP ✓" || warn "Brave Search MCP — ошибка"
else
    warn "Brave Search MCP пропущен — нужен BRAVE_API_KEY"
    info "Получи бесплатный ключ: https://api.search.brave.com"
fi

# ── 3.4 GitHub ──────────────────────────────────────────────
info "GitHub MCP (управление репозиториями)..."
claude mcp add github \
    --scope user \
    --transport http \
    https://api.githubcopilot.com/mcp/ && log "GitHub MCP ✓" || warn "GitHub MCP — ошибка, пропускаю"

# ── 3.5 Supabase / PostgreSQL ───────────────────────────────
if [ -n "$SUPABASE_URL" ] && [ -n "$SUPABASE_KEY" ]; then
    info "Supabase MCP (база данных для ботов и RAG)..."
    claude mcp add supabase \
        --scope user \
        --transport stdio \
        -e SUPABASE_URL="$SUPABASE_URL" \
        -e SUPABASE_SERVICE_ROLE_KEY="$SUPABASE_KEY" \
        -- npx -y @supabase/mcp-server-supabase@latest && log "Supabase MCP ✓" || warn "Supabase MCP — ошибка"
else
    warn "Supabase MCP пропущен — нужны SUPABASE_URL и SUPABASE_KEY"
    info "Зарегистрируйся: https://supabase.com (бесплатный tier)"
fi

# ── 3.6 Sequential Thinking ─────────────────────────────────
info "Sequential Thinking MCP (сложные многошаговые задачи)..."
claude mcp add sequentialthinking \
    --scope user \
    --transport stdio \
    -- npx -y @modelcontextprotocol/server-sequential-thinking && log "Sequential Thinking MCP ✓" || warn "Sequential Thinking MCP — ошибка"

# ── 3.7 Fetch / HTTP ────────────────────────────────────────
info "Fetch MCP (HTTP запросы к API, вебхуки)..."
claude mcp add fetch \
    --scope user \
    --transport stdio \
    -- npx -y @modelcontextprotocol/server-fetch && log "Fetch MCP ✓" || warn "Fetch MCP — ошибка"

# ── 3.8 Puppeteer (альтернатива Playwright) ─────────────────
info "Puppeteer MCP (скрейпинг, генерация скриншотов)..."
claude mcp add puppeteer \
    --scope user \
    --transport stdio \
    -- npx -y @modelcontextprotocol/server-puppeteer && log "Puppeteer MCP ✓" || warn "Puppeteer MCP — ошибка"

# ── 3.9 Memory (долгосрочная память агентов) ────────────────
info "Memory MCP (память для AI консультантов/ботов)..."
claude mcp add memory \
    --scope user \
    --transport stdio \
    -- npx -y @modelcontextprotocol/server-memory && log "Memory MCP ✓" || warn "Memory MCP — ошибка"

# ── 3.10 ElevenLabs (озвучка для видео) ─────────────────────
info "ElevenLabs MCP (TTS для видео контента)..."
claude mcp add elevenlabs \
    --scope user \
    --transport http \
    https://mcp.elevenlabs.io/mcp && log "ElevenLabs MCP ✓" || warn "ElevenLabs MCP — нужна регистрация на elevenlabs.io"

header "4. Создание CLAUDE.md (глобальный профиль)"

cat > ~/.claude/CLAUDE.md << 'CLAUDEMD'
# Мой профиль разработчика

## Стек и предпочтения
- Backend: Python (FastAPI, aiogram, python-telegram-bot), Node.js
- DB: PostgreSQL + pgvector, SQLite, Supabase
- Deploy: Railway, Vercel, Docker
- AI: Claude API (Anthropic), OpenAI
- Язык общения: русский/украинский

## Мои основные задачи

### 1. n8n / Make автоматизации
- n8n self-hosted: rew.app.n8n.cloud
- Создавать workflows через JSON экспорт
- Предпочитать webhook-триггеры
- Всегда добавлять error handling ноды
- Make.com для простых автоматизаций

### 2. Telegram боты
- Использовать aiogram 3.x (async)
- Структура: handlers/, keyboards/, services/, middlewares/
- FSM для многошаговых диалогов
- Хранить токены в .env
- Добавлять admin панель

### 3. AI консультанты / продажники для сайтов
- RAG через pgvector или Supabase
- Виджет: чистый JS или React компонент
- API: FastAPI backend
- Логировать диалоги в БД
- Система эскалации на живого менеджера

### 4. Генерация видео и изображений
- Изображения: fal.ai (Flux), Replicate
- Видео: Runway ML API, Kling AI
- Хранение: Cloudinary (уже подключен)
- Пайплайн: промпт → генерация → загрузка в Cloudinary → URL

## Правила написания кода
- Всегда добавлять .env.example
- Dockerfile если проект деплоится
- README.md с инструкцией запуска
- Комментарии на русском
- Логирование через loguru (Python) или winston (Node)
- Никогда не хардкодить ключи API

## Мои проекты
- TI-Katalog: FastAPI + Next.js + pgvector (Railway/Vercel)
  Репо: sergeylkn/ti-catalog1
- CatalogIQ: локальный AI ассистент (Python + SQLite + TF-IDF)
- Dubify AI: Chrome Extension для AI дубляжа видео
CLAUDEMD

log "CLAUDE.md создан: ~/.claude/CLAUDE.md"

header "5. Проверка установленных серверов"

echo ""
claude mcp list 2>/dev/null || warn "Запусти 'claude mcp list' вручную для проверки"

header "6. Что нужно заполнить вручную"

echo ""
echo -e "${YELLOW}Обязательно получи эти ключи и перезапусти скрипт:${NC}"
echo ""
echo -e "  ${CYAN}BRAVE_API_KEY${NC}    → https://api.search.brave.com (Free: 2000 req/mo)"
echo -e "  ${CYAN}SUPABASE_URL${NC}     → https://supabase.com → Settings → API"
echo -e "  ${CYAN}SUPABASE_KEY${NC}     → Service Role Key (там же)"
echo ""
echo -e "${YELLOW}Для AI генерации видео/фото:${NC}"
echo -e "  ${CYAN}fal.ai${NC}           → https://fal.ai (Flux SDXL, бесплатные кредиты)"
echo -e "  ${CYAN}Replicate${NC}        → https://replicate.com (pay per use)"
echo -e "  ${CYAN}Runway ML${NC}        → https://runwayml.com (видео из текста)"
echo -e "  ${CYAN}ElevenLabs${NC}       → https://elevenlabs.io (TTS, Free: 10k символов/мес)"
echo ""
echo -e "${YELLOW}Для Telegram ботов:${NC}"
echo -e "  ${CYAN}BotFather${NC}        → https://t.me/BotFather → /newbot"
echo ""
echo -e "${GREEN}══════════════════════════════════════════${NC}"
echo -e "${GREEN}  Установка завершена! Запусти: claude${NC}"
echo -e "${GREEN}══════════════════════════════════════════${NC}"
echo ""
