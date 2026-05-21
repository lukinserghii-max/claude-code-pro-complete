#!/usr/bin/env bash
# ============================================================
# CLAUDE CODE PRO SETUP — установка всех лучших скилов и агентов
# 
# Источники:
# 1. obra/superpowers (195k+ stars) — TDD, debugging, collaboration
# 2. anthropics/skills (official) — PDF, DOCX, XLSX, PPTX
# 3. alirezarezvani/claude-skills (313+ skills) — engineering, marketing, compliance
# 4. ComposioHQ/awesome-claude-skills (automation & agents)
# 5. BehiSecc/awesome-claude-skills (security, testing, content)
# 6. glebis/claude-skills (health, TTS, creative)
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
header() { echo -e "\n${BLUE}══════════════════════════════════════════════════════════${NC}"; echo -e "${BLUE}  $1${NC}"; echo -e "${BLUE}══════════════════════════════════════════════════════════${NC}\n"; }
fail()   { echo -e "${RED}✗${NC} $1"; exit 1; }

# ── Конфигурация ────────────────────────────────────────────────────
CLAUDE_DIR="$HOME/.claude"
SKILLS_DIR="$CLAUDE_DIR/skills"
AGENTS_DIR="$CLAUDE_DIR/agents"
PLUGINS_DIR="$CLAUDE_DIR/plugins"
TEMP_DIR="/tmp/claude-install-$$"

mkdir -p "$SKILLS_DIR" "$AGENTS_DIR" "$PLUGINS_DIR" "$TEMP_DIR"

# ── Проверка зависимостей ──────────────────────────────────────────
header "STEP 1: Проверка зависимостей"

if ! command -v git &>/dev/null; then
    fail "Git не установлен. Установи через: apt-get install git (Linux) или brew install git (Mac)"
fi
log "Git установлен: $(git --version | head -1)"

if ! command -v node &>/dev/null; then
    fail "Node.js не установлен. Установи с https://nodejs.org"
fi
log "Node.js: $(node --version)"

if ! command -v npm &>/dev/null; then
    fail "npm не установлен"
fi
log "npm: $(npm --version)"

# ── ОСНОВНЫЕ СКИЛЫ (Anthropic Official) ─────────────────────────────
header "STEP 2: Официальные скилы Anthropic"

info "Скилы для работы с документами (PDF, DOCX, XLSX, PPTX)..."
declare -a OFFICIAL_SKILLS=(
    "docx"
    "pdf"
    "xlsx"
    "pptx"
    "frontend-design"
    "canvas-design"
    "algorithmic-art"
    "theme-factory"
)

for skill in "${OFFICIAL_SKILLS[@]}"; do
    if [ -d "$SKILLS_DIR/$skill" ]; then
        warn "Skill '$skill' уже установлен, пропускаю"
    else
        info "Клонирую $skill..."
        git clone --depth 1 "https://github.com/anthropics/skills.git" "$TEMP_DIR/skills-repo" 2>/dev/null
        if [ -d "$TEMP_DIR/skills-repo/$skill" ]; then
            cp -r "$TEMP_DIR/skills-repo/$skill" "$SKILLS_DIR/"
            log "Установлен: $skill"
        else
            warn "Скил $skill не найден в репо"
        fi
        rm -rf "$TEMP_DIR/skills-repo"
    fi
done

# ── SUPERPOWERS (obra) — лучший набор для разработки ────────────────
header "STEP 3: Superpowers Framework (obra) — TDD, Debugging, Collaboration"

info "Клонирую obra/superpowers (195k+ звёзд)..."
if [ -d "$PLUGINS_DIR/superpowers" ]; then
    warn "Superpowers уже клонирован, обновляю..."
    cd "$PLUGINS_DIR/superpowers" && git pull origin main
else
    git clone https://github.com/obra/superpowers.git "$PLUGINS_DIR/superpowers" 2>/dev/null
fi
log "Superpowers установлены"

# Дополнительные маркетплейсы от obra
declare -a OBRA_PLUGINS=(
    "superpowers-marketplace"
    "superpowers-skills"
    "superpowers-developing-for-claude-code"
)

for plugin in "${OBRA_PLUGINS[@]}"; do
    info "Клонирую obra/$plugin..."
    if [ ! -d "$PLUGINS_DIR/$plugin" ]; then
        git clone https://github.com/obra/$plugin.git "$PLUGINS_DIR/$plugin" 2>/dev/null
    else
        cd "$PLUGINS_DIR/$plugin" && git pull
    fi
    log "$plugin готов"
done

# ── ИНЖЕНЕРНЫЕ СКИЛЫ (alirezarezvani — 313+ скилов) ──────────────────
header "STEP 4: Инженерные скилы (alirezarezvani/claude-skills)"

info "Клонирую 313+ production-ready скилов..."
if [ ! -d "$PLUGINS_DIR/claude-skills-main" ]; then
    git clone https://github.com/alirezarezvani/claude-skills.git "$PLUGINS_DIR/claude-skills-main" 2>/dev/null
else
    cd "$PLUGINS_DIR/claude-skills-main" && git pull
fi
log "claude-skills-main установлены"

# Копируем популярные скилы в SKILLS_DIR
declare -a POPULAR_SKILLS=(
    "senior-architect"
    "test-driven-development"
    "code-reviewer"
    "security-auditor"
    "performance-optimizer"
    "documentation-generator"
)

for skill in "${POPULAR_SKILLS[@]}"; do
    if [ -d "$PLUGINS_DIR/claude-skills-main/$skill" ]; then
        cp -r "$PLUGINS_DIR/claude-skills-main/$skill" "$SKILLS_DIR/" 2>/dev/null && log "Скопирован: $skill"
    fi
done

# ── АВТОМАТИЗАЦИЯ И ИНТЕГРАЦИИ (ComposioHQ) ─────────────────────────
header "STEP 5: Automation & Integration Skills"

info "Клонирую ComposioHQ/awesome-claude-skills..."
if [ ! -d "$PLUGINS_DIR/composio-skills" ]; then
    git clone https://github.com/ComposioHQ/awesome-claude-skills.git "$PLUGINS_DIR/composio-skills" 2>/dev/null
else
    cd "$PLUGINS_DIR/composio-skills" && git pull
fi
log "Composio skills установлены"

# ── БЕЗОПАСНОСТЬ И КАЧЕСТВО КОДА (BehiSecc) ───────────────────────────
header "STEP 6: Security & Code Quality Skills"

info "Клонирую BehiSecc/awesome-claude-skills..."
if [ ! -d "$PLUGINS_DIR/behisecc-skills" ]; then
    git clone https://github.com/BehiSecc/awesome-claude-skills.git "$PLUGINS_DIR/behisecc-skills" 2>/dev/null
else
    cd "$PLUGINS_DIR/behisecc-skills" && git pull
fi
log "BehiSecc skills установлены"

# Копируем важные скилы
declare -a SECURITY_SKILLS=(
    "owasp-security"
    "debug-skill"
    "qa-tester"
)

for skill in "${SECURITY_SKILLS[@]}"; do
    if [ -d "$PLUGINS_DIR/behisecc-skills/$skill" ]; then
        cp -r "$PLUGINS_DIR/behisecc-skills/$skill" "$SKILLS_DIR/" 2>/dev/null && log "Скопирован: $skill"
    fi
done

# ── СПЕЦИАЛИЗИРОВАННЫЕ СКИЛЫ (glebis) ──────────────────────────────────
header "STEP 7: Specialized Skills (Health, TTS, Creative)"

info "Клонирую glebis/claude-skills..."
if [ ! -d "$PLUGINS_DIR/glebis-skills" ]; then
    git clone https://github.com/glebis/claude-skills.git "$PLUGINS_DIR/glebis-skills" 2>/dev/null
else
    cd "$PLUGINS_DIR/glebis-skills" && git pull
fi
log "glebis skills установлены"

# ── ТВОИ КАСТОМНЫЕ АГЕНТЫ ──────────────────────────────────────────────
header "STEP 8: Установка 32 кастомных агентов (Sergey's Custom Agents)"

info "Распаковываю архив с агентами..."
if [ -f "claude-agents.tar.gz" ]; then
    tar -xzf claude-agents.tar.gz -C "$AGENTS_DIR" 2>/dev/null
    COUNT=$(ls "$AGENTS_DIR"/*.md 2>/dev/null | wc -l)
    log "Распакован$COUNT агентов"
else
    warn "claude-agents.tar.gz не найден в текущей папке"
    info "Создаю примеры агентов..."
    cp -r ".claude/agents/"* "$AGENTS_DIR/" 2>/dev/null || true
fi

# ── СОЗДАНИЕ CLAUDE.MD ──────────────────────────────────────────────────
header "STEP 9: Создание глобального CLAUDE.md"

cat > "$CLAUDE_DIR/CLAUDE.md" << 'CLAUDEMD'
# Claude Code Pro Profile — Sergey's Setup

## Стек и платформы
- **Backend**: Python (FastAPI), Node.js
- **Frontend**: Next.js 15, React, Tailwind
- **Databases**: PostgreSQL + pgvector, SQLite, Supabase
- **Automation**: n8n (rew.app.n8n.cloud), Make.com
- **Deployment**: Railway, Vercel, Docker
- **Messaging**: Telegram Bot API (aiogram 3.x)
- **AI**: Claude API, OpenAI, fal.ai, Runway ML
- **Storage**: Cloudinary (R2 backup)

## Основные проекты
1. **TI-Katalog** — FastAPI + Next.js + pgvector на Railway/Vercel
   Репо: sergeylkn/ti-catalog1
2. **CatalogIQ** — локальный AI ассистент (Python + SQLite + TF-IDF)
3. **Dubify AI** — Chrome Extension для AI дубляжа видео

## Включенные инструменты

### Claude Code Plugins
- **superpowers** — TDD, debugging, collaboration patterns (obra)
- **composio-skills** — workflow automation & integrations
- **security-skills** — OWASP, code audit, compliance

### Installed Skills Collections
```
~/claude/skills/
  ├── docx/ pdf/ xlsx/ pptx/     (документы)
  ├── frontend-design/            (UI/UX)
  ├── canvas-design/              (графика)
  ├── algorithmic-art/            (генеративное)
  ├── test-driven-development/    (TDD)
  ├── code-reviewer/              (code review)
  ├── senior-architect/           (архитектура)
  └── [+ 40+ других скилов]
```

### 32 Custom Agents
```
~/claude/agents/
  ├── Автоматизации (5)
  │   n8n-architect, make-builder, webhook-engineer, api-integrator, data-transformer
  ├── Боты и продажи (6)
  │   telegram-bot-dev, sales-bot-designer, ai-consultant-builder, crm-integrator, 
  │   lead-qualifier, support-agent
  ├── Контент (7)
  │   copywriter, prompt-engineer, image-pipeline, video-director, 
  │   content-strategist, seo-specialist, social-media-manager
  ├── Технические (5)
  │   python-dev, frontend-dev, devops-engineer, database-architect, security-auditor
  └── Бизнес/аналитика (9)
      business-analyst, data-analyst, market-researcher, project-manager, 
      code-reviewer, qa-tester, documentation-writer, email-marketer, translator
```

## MCP Servers (через ~/.claude.json)
- filesystem — доступ к файлам
- playwright — браузерная автоматизация
- brave-search — веб-поиск
- supabase — база данных
- sequential-thinking — многошаговое мышление
- fetch — HTTP запросы
- elevenlabs — TTS озвучка
- memory — долгосрочная память
- github — управление репозиториями

## Правила работы

### Использование скилов
- `/skill <name>` — активировать конкретный скил
- Скилы активируются автоматически по контексту
- Для документов: используй docx/pdf/xlsx/pptx скилы
- Для фронта: используй frontend-design скил
- Для тестирования: используй test-driven-development скил

### Использование агентов
```bash
# В Claude Code
/agent n8n-architect "создай workflow для квалификации лидов"
/agent telegram-bot-dev "напиши бота для продаж"
/agent ai-consultant-builder "построй RAG систему для FAQ"
```

### Выполнение задач
1. **Планирование** — /brainstorm (из superpowers)
2. **Проектирование** — используй правильный агент
3. **Разработка** — /write-plan + /execute-plan
4. **Тестирование** — /test-driven-development
5. **Код-ревью** — /code-reviewer
6. **Деплой** — devops-engineer агент

## Окружение
- Язык: Русский/Украинский (по необходимости)
- Проекты хранятся в ~/projects/
- Временные файлы в /tmp/
- Логирование через loguru (Python) или winston (Node)

## Безопасность
- Никогда не хардкодить ключи API
- Использовать .env для всех секретов
- Добавлять .env.example в репо
- Использовать Railway Secrets и Vercel Environment Variables
- Скилы для security-аудита активируются при работе с секретами

## Непрерывное обучение
- Проверять обновления скилов еженедельно
- Смотреть /superpowers:help для новых команд
- Экспериментировать с новыми скилами из репозиториев
- Документировать найденные паттерны и лучшие практики

---
Последнее обновление: $(date)
CLAUDEMD

log "CLAUDE.md создан: $CLAUDE_DIR/CLAUDE.md"

# ── СОЗДАНИЕ CLAUDE.JSON (для MCP серверов) ────────────────────────────
header "STEP 10: Создание ~/.claude.json (MCP конфигурация)"

cat > "$CLAUDE_DIR/claude.json" << 'CLAUDEJSON'
{
  "mcpServers": {
    "filesystem": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "$HOME/projects", "$HOME/Downloads"],
      "comment": "Доступ к файлам проектов"
    },
    "playwright": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"],
      "comment": "Браузерная автоматизация и тестирование"
    },
    "brave-search": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-brave-search"],
      "env": {
        "BRAVE_API_KEY": "ВСТАВЬ_КЛЮЧ"
      },
      "comment": "Веб-поиск: https://api.search.brave.com — Free 2000 req/mo"
    },
    "supabase": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@supabase/mcp-server-supabase@latest"],
      "env": {
        "SUPABASE_URL": "https://ТВОЙ_ПРОЕКТ.supabase.co",
        "SUPABASE_SERVICE_ROLE_KEY": "ВСТАВЬ_KEY"
      },
      "comment": "База данных: https://supabase.com"
    },
    "sequentialthinking": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"],
      "comment": "Глубокое многошаговое мышление"
    },
    "fetch": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-fetch"],
      "comment": "HTTP запросы к API и вебхукам"
    },
    "memory": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"],
      "comment": "Долгосрочная память для агентов"
    },
    "elevenlabs": {
      "type": "http",
      "url": "https://mcp.elevenlabs.io/mcp",
      "comment": "TTS озвучка: https://elevenlabs.io"
    }
  }
}
CLAUDEJSON

log "claude.json создан: $CLAUDE_DIR/claude.json"

# ── СТАТИСТИКА И ИТОГИ ─────────────────────────────────────────────────
header "STEP 11: Финальная проверка"

SKILLS_COUNT=$(find "$SKILLS_DIR" -maxdepth 1 -type d | wc -l)
AGENTS_COUNT=$(ls "$AGENTS_DIR"/*.md 2>/dev/null | wc -l)
PLUGINS_COUNT=$(ls -d "$PLUGINS_DIR"/*/ 2>/dev/null | wc -l)

echo ""
echo -e "${GREEN}════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  ✓ УСТАНОВКА ЗАВЕРШЕНА УСПЕШНО!${NC}"
echo -e "${GREEN}════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "  ${CYAN}Скилы${NC}:         $((SKILLS_COUNT - 1)) установлено"
echo -e "  ${CYAN}Агенты${NC}:        $AGENTS_COUNT установлено"
echo -e "  ${CYAN}Плагины${NC}:       $PLUGINS_COUNT установлено"
echo -e "  ${CYAN}Главный конфиг${NC}: $CLAUDE_DIR/CLAUDE.md"
echo ""

# ── ИНСТРУКЦИИ ──────────────────────────────────────────────────────────
header "СЛЕДУЮЩИЕ ШАГИ"

echo -e "${YELLOW}1. Получи API ключи:${NC}"
echo -e "   • Brave Search:   ${CYAN}https://api.search.brave.com${NC} (Free: 2000 req/mo)"
echo -e "   • Supabase:       ${CYAN}https://supabase.com${NC} → Settings → API (Free tier)"
echo -e "   • ElevenLabs:     ${CYAN}https://elevenlabs.io${NC} (Free: 10k символов/мес)"
echo ""

echo -e "${YELLOW}2. Обнови переменные в ~/.claude/claude.json:${NC}"
echo -e "   ${CYAN}nano ~/.claude/claude.json${NC}"
echo -e "   Найди 'ВСТАВЬ_КЛЮЧ' и замени на реальные значения"
echo ""

echo -e "${YELLOW}3. Запусти Claude Code:${NC}"
echo -e "   ${CYAN}claude${NC}"
echo ""

echo -e "${YELLOW}4. Проверь установку:${NC}"
echo -e "   • ${CYAN}/plugin list${NC} — список установленных плагинов"
echo -e "   • ${CYAN}/skill list${NC} — список доступных скилов"
echo -e "   • ${CYAN}/agent list${NC} — список агентов"
echo -e "   • ${CYAN}/brainstorm${NC} — тест Superpowers"
echo ""

echo -e "${YELLOW}5. Используй агентов:${NC}"
echo -e "   ${CYAN}/agent n8n-architect${NC} \"создай workflow для продаж\""
echo -e "   ${CYAN}/agent telegram-bot-dev${NC} \"напиши бота для FAQ\""
echo -e "   ${CYAN}/agent ai-consultant-builder${NC} \"построй RAG систему\""
echo ""

echo -e "${YELLOW}6. Документация:${NC}"
echo -e "   • Superpowers:    ${CYAN}https://github.com/obra/superpowers${NC}"
echo -e "   • Anthropic Docs: ${CYAN}https://docs.claude.com${NC}"
echo -e "   • МОИ АГЕНТЫ:     ${CYAN}~/.claude/agents/${NC}"
echo ""

# ── ОЧИСТКА ─────────────────────────────────────────────────────────────
rm -rf "$TEMP_DIR"

echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  Всё готово! Запусти: ${CYAN}claude${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
echo ""
