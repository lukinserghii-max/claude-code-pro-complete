#!/usr/bin/env bash
# Установщик 32 агентов для Claude Code
# Запускай из папки где лежит этот файл вместе с claude-agents.tar.gz

set -e
GREEN='\033[0;32m'; NC='\033[0m'

echo -e "${GREEN}Устанавливаю 32 агента в ~/.claude/agents/${NC}"

mkdir -p ~/.claude/agents

# Распаковываем архив
tar -xzf claude-agents.tar.gz -C ~/

COUNT=$(ls ~/.claude/agents/*.md | wc -l)
echo -e "${GREEN}✓ Установлено агентов: $COUNT${NC}"
echo ""
echo "Проверь: ls ~/.claude/agents/"
echo "Использование в Claude Code: claude --agent n8n-architect"
