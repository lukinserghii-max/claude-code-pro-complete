#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
#  ЗАПУСК В ТЕРМИНАЛЕ VS CODE (Git Bash / zsh / bash):
#  
#  1. Положи этот файл рядом с CLAUDE.md
#  2. Открой терминал в VS Code: Ctrl + `
#  3. Запусти: bash run.sh
# ═══════════════════════════════════════════════════════════════

set -e

GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}"
echo "╔══════════════════════════════════════════════════════╗"
echo "║   CLAUDE CODE PRO — АВТОМАТИЧЕСКАЯ УСТАНОВКА        ║"
echo "╚══════════════════════════════════════════════════════╝"
echo -e "${NC}"

# ── Проверка зависимостей ─────────────────────────────────────
echo -e "${CYAN}[1/7]${NC} Проверка зависимостей..."

for cmd in git node npm curl; do
  if command -v $cmd &>/dev/null; then
    echo -e "  ${GREEN}✓${NC} $cmd: $(${cmd} --version 2>/dev/null | head -1)"
  else
    echo -e "  ✗ $cmd не найден!"
    case $cmd in
      git)  echo "  → Установи: https://git-scm.com/downloads" ;;
      node) echo "  → Установи: https://nodejs.org (LTS версия)" ;;
      npm)  echo "  → Устанавливается вместе с Node.js" ;;
      curl) echo "  → Обычно уже есть. На Windows — включи в системных компонентах" ;;
    esac
    exit 1
  fi
done

# ── Claude Code ───────────────────────────────────────────────
echo ""
echo -e "${CYAN}[2/7]${NC} Проверка Claude Code..."

if command -v claude &>/dev/null; then
  echo -e "  ${GREEN}✓${NC} Claude Code уже установлен"
else
  echo "  → Устанавливаю Claude Code..."
  npm install -g @anthropic-ai/claude-code
  echo -e "  ${GREEN}✓${NC} Claude Code установлен"
fi

# ── Директории ───────────────────────────────────────────────
echo ""
echo -e "${CYAN}[3/7]${NC} Создание директорий..."

mkdir -p ~/.claude/agents
mkdir -p ~/.claude/skills
mkdir -p ~/.claude/plugins
mkdir -p ~/claude-code-pro-complete

echo -e "  ${GREEN}✓${NC} ~/.claude/agents/"
echo -e "  ${GREEN}✓${NC} ~/.claude/skills/"
echo -e "  ${GREEN}✓${NC} ~/claude-code-pro-complete/"

# ── Агенты ───────────────────────────────────────────────────
echo ""
echo -e "${CYAN}[4/7]${NC} Установка 32 агентов..."

ARCHIVE=""
for path in \
  "$(dirname "$0")/claude-agents-optimized.tar.gz" \
  ~/Downloads/claude-agents-optimized.tar.gz \
  ~/Desktop/claude-agents-optimized.tar.gz \
  ~/Documents/claude-agents-optimized.tar.gz; do
  if [ -f "$path" ]; then
    ARCHIVE="$path"
    break
  fi
done

if [ -n "$ARCHIVE" ]; then
  cd ~/claude-code-pro-complete
  tar -xzf "$ARCHIVE"
  cp claude-agents-optimized/*.md ~/.claude/agents/ 2>/dev/null || true
  COUNT=$(ls ~/.claude/agents/*.md 2>/dev/null | wc -l)
  echo -e "  ${GREEN}✓${NC} Агентов установлено: $COUNT"
else
  echo -e "  ${YELLOW}⚠${NC}  Архив claude-agents-optimized.tar.gz не найден"
  echo "     Положи его рядом с run.sh или в ~/Downloads/"
fi

# ── GitHub репо ───────────────────────────────────────────────
echo ""
echo -e "${CYAN}[5/7]${NC} Создание GitHub репозитория..."

GITHUB_TOKEN="YOUR_GITHUB_TOKEN"
GITHUB_USER="sergeylkn"
REPO_NAME="claude-code-pro-complete"

HTTP_CODE=$(curl -s -o /tmp/gh_response.json -w "%{http_code}" \
  -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  -d "{\"name\":\"$REPO_NAME\",\"description\":\"🚀 88+ компонентов для Claude Code — 32 агента, 40+ скилов, 10 MCP серверов\",\"private\":false}" \
  https://api.github.com/user/repos)

if [ "$HTTP_CODE" = "201" ]; then
  echo -e "  ${GREEN}✓${NC} Репозиторий создан: https://github.com/$GITHUB_USER/$REPO_NAME"
elif [ "$HTTP_CODE" = "422" ]; then
  echo -e "  ${GREEN}✓${NC} Репозиторий уже существует — продолжаю"
else
  echo -e "  ${YELLOW}⚠${NC}  GitHub API вернул: $HTTP_CODE"
  cat /tmp/gh_response.json 2>/dev/null | python3 -c "import sys,json; d=json.load(sys.stdin); print('  ', d.get('message',''))" 2>/dev/null || true
fi

# ── Git push ──────────────────────────────────────────────────
echo ""
echo -e "${CYAN}[6/7]${NC} Загрузка файлов на GitHub..."

cd ~/claude-code-pro-complete

# Копируем скрипты если рядом лежат
SCRIPT_DIR="$(dirname "$0")"
for f in CLAUDE.md README.md QUICK_START.md install-all-claude-code.sh full-install.sh; do
  [ -f "$SCRIPT_DIR/$f" ] && cp "$SCRIPT_DIR/$f" . 2>/dev/null || true
done

git init -q 2>/dev/null || true
git config user.email "$GITHUB_USER@users.noreply.github.com"
git config user.name "$GITHUB_USER"
git add .

if git diff --cached --quiet 2>/dev/null; then
  echo -e "  ${GREEN}✓${NC} Нечего коммитить — уже актуально"
else
  git commit -q -m "🚀 Claude Code Pro Complete — $(date '+%Y-%m-%d')"
  echo -e "  ${GREEN}✓${NC} Commit создан"
fi

REMOTE_URL="https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git"
git remote remove origin 2>/dev/null || true
git remote add origin "$REMOTE_URL"
git branch -M main

if git push -u origin main --force -q 2>/dev/null; then
  echo -e "  ${GREEN}✓${NC} Загружено: https://github.com/$GITHUB_USER/$REPO_NAME"
else
  echo -e "  ${YELLOW}⚠${NC}  Push не удался — проверь токен или интернет"
fi

# ── MCP серверы ───────────────────────────────────────────────
echo ""
echo -e "${CYAN}[7/7]${NC} Установка MCP серверов и плагинов..."

MCP_INSTALLER=""
for path in \
  "$(dirname "$0")/install-all-claude-code.sh" \
  ~/Downloads/install-all-claude-code.sh; do
  if [ -f "$path" ]; then
    MCP_INSTALLER="$path"
    break
  fi
done

if [ -n "$MCP_INSTALLER" ]; then
  bash "$MCP_INSTALLER"
  echo -e "  ${GREEN}✓${NC} MCP серверы и плагины установлены"
else
  echo -e "  ${YELLOW}⚠${NC}  install-all-claude-code.sh не найден рядом"
  echo "     Положи его рядом с run.sh или скачай из чата"
fi

# ── CLAUDE.md ─────────────────────────────────────────────────
if [ ! -f ~/.claude/CLAUDE.md ]; then
cat > ~/.claude/CLAUDE.md << 'CLAUDEMD'
# Claude Code Pro — Sergey's Setup

## Stack
- Backend: Python (FastAPI), Node.js
- Frontend: Next.js 15, React, Tailwind CSS
- DB: PostgreSQL + pgvector, Supabase
- Automation: n8n (rew.app.n8n.cloud), Make.com
- Deploy: Railway, Vercel, Docker
- Bots: Telegram (aiogram 3.x)
- AI: Claude API, fal.ai, Runway ML
- Storage: Cloudinary

## Rules
- Комментарии в коде на русском
- Всегда .env для секретов (никогда не хардкодить)
- Всегда Dockerfile
- Типизация везде (TypeScript/Python type hints)
- Логирование через loguru (Python) или winston (Node)
- Тесты обязательны
CLAUDEMD
  echo -e "  ${GREEN}✓${NC} ~/.claude/CLAUDE.md создан"
fi

# ── ИТОГ ──────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  🎉 УСТАНОВКА ЗАВЕРШЕНА!${NC}"
echo -e "${GREEN}══════════════════════════════════════════════════════${NC}"
echo ""
echo -e "  Агентов:  $(ls ~/.claude/agents/*.md 2>/dev/null | wc -l)"
echo -e "  Скилов:   $(ls -d ~/.claude/skills/*/ 2>/dev/null | wc -l)"
echo -e "  GitHub:   https://github.com/sergeylkn/claude-code-pro-complete"
echo ""
echo -e "  ${CYAN}Запусти Claude Code:${NC}"
echo -e "  ${GREEN}claude${NC}"
echo ""
echo -e "  ${CYAN}Первая команда:${NC}"
echo -e "  ${GREEN}/brainstorm${NC}"
echo ""
