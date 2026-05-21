# 🚀 Claude Code Pro — Complete Setup Package

**Универсальный установщик для Claude Code с 88+ компонентами из лучших GitHub репозиториев**

---

## 📦 Что входит в пакет

### 1️⃣ **Superpowers Framework** (195k+ ⭐)
- 20+ battle-tested skills for Claude Code
- TDD workflow с `/brainstorm`, `/write-plan`, `/execute-plan`
- Debugging, collaboration, best practices
- **Автор:** Jesse Vincent (obra)
- **Ссылка:** https://github.com/obra/superpowers

### 2️⃣ **Official Anthropic Skills** (136k+ ⭐)
Документы и дизайн:
- **docx** — создание и редактирование Word
- **pdf** — извлечение, слияние, аннотирование
- **xlsx** — таблицы, формулы, диаграммы
- **pptx** — PowerPoint презентации
- **frontend-design** — компоненты React/Tailwind
- **canvas-design** — графика и дизайн
- **algorithmic-art** — генеративное искусство
- **theme-factory** — оформление артефактов

### 3️⃣ **313+ инженерных скилов** (alirezarezvani)
Огромная библиотека:
- 313 production-ready скилов
- Работает с Claude Code, Codex, Cursor, Windsurf
- Скилы для: инженеров, маркетеров, compliance, PM, C-level
- **Ссылка:** https://github.com/alirezarezvani/claude-skills

### 4️⃣ **Automation & Integration** (ComposioHQ)
Workflow автоматизация:
- Интеграция с Zapier, n8n, Make, Airtable
- API automation скилы
- **Ссылка:** https://github.com/ComposioHQ/awesome-claude-skills

### 5️⃣ **Security & Code Quality** (BehiSecc)
Профессиональные скилы:
- OWASP Top 10 + ASVS 5.0
- Статический анализ (CodeQL, Semgrep)
- Тестирование и QA
- Vulnerability detection
- **Ссылка:** https://github.com/BehiSecc/awesome-claude-skills

### 6️⃣ **Specialized Skills** (glebis)
Узкоспециализированные:
- Health metrics (Apple Health API)
- TTS озвучка (ElevenLabs)
- Психотерапевтические техники (CBT, DBT)
- Многоагентное TDD
- **Ссылка:** https://github.com/glebis/claude-skills

### 7️⃣ **32 кастомных агента** (Sergey's Setup)
Специалисты для твоих задач:
- **5 агентов** для автоматизации (n8n, Make, API)
- **6 агентов** для ботов и продаж (Telegram, CRM, AI консультанты)
- **7 агентов** для контента (копирайтинг, видео, фото, SEO)
- **5 агентов** для разработки (Python, Frontend, DevOps, БД)
- **9 агентов** для бизнеса (аналитика, маркетинг, менеджмент)

### 8️⃣ **10 MCP серверов**
Расширение возможностей:
- `filesystem` — доступ к файлам проектов
- `playwright` — браузерная автоматизация и тестирование
- `brave-search` — веб-поиск в агентах
- `supabase` — база данных PostgreSQL
- `sequentialthinking` — глубокое аналитическое мышление
- `fetch` — HTTP запросы к любым API
- `memory` — долгосрочная память для агентов
- `elevenlabs` — TTS озвучка
- `github` — управление репозиториями
- `puppeteer` — скрейпинг и автоматизация браузера

---

## ⚡ Быстрая установка (3 минуты)

### Требования
- `git` (для клонирования репозиториев)
- `node >= 18` и `npm`
- Claude Code установлен (`npm install -g @anthropic-ai/claude-code`)
- ~500 MB свободного места

### Установка

```bash
# 1. Скачай архив и распакуй
tar -xzf claude-code-pro-setup.tar.gz
cd claude-code-pro-setup

# 2. Запусти установщик
chmod +x install-all-claude-code.sh
./install-all-claude-code.sh

# 3. Получи API ключи (5 минут, опционально для расширенного функционала)
# Brave Search:   https://api.search.brave.com
# Supabase:       https://supabase.com
# ElevenLabs:     https://elevenlabs.io

# 4. Обновь ключи в конфиге
nano ~/.claude/claude.json

# 5. Запусти Claude Code
claude
```

**Что произойдет:**
✅ Клонируются 6 основных репозиториев  
✅ Установятся 40+ скилов  
✅ Загрузятся 32 кастомных агента  
✅ Создадутся конфиги MCP серверов  
✅ Готово к использованию!

---

## 📖 Использование

### Активация скилов
```bash
/skill test-driven-development    # Режим TDD для новой функции
/skill code-reviewer              # Проверка и рефакторинг
/skill security-auditor           # Аудит безопасности
/skill docx                        # Работа с Word документами
/skill pdf                         # PDF обработка
```

### Использование агентов
```bash
# Автоматизация
/agent n8n-architect
"Создай workflow в n8n для обработки платежей Stripe → запись в БД → уведомление в Slack"

# Telegram боты
/agent telegram-bot-dev
"Напиши бота для продажи с каталогом, корзиной и платежами. Stack: aiogram 3.x, PostgreSQL, Railway"

# Разработка
/agent python-dev
"FastAPI сервер с MongoDB, JWT авторизацией и WebSocket для real-time уведомлений"

# Маркетинг
/agent copywriter
"Напиши welcome-серию из 5 писем для новых подписчиков SaaS"
```

### Полезные команды
```bash
/plugin list                       # Список установленных плагинов
/plugin install <name>             # Установить новый плагин
/skill list                        # Список всех скилов
/skill <name>                      # Активировать скил
/agent list                        # Список агентов

# Superpowers commands
/brainstorm                        # Планирование (БЕЗ ЭТОГО НЕ НАЧИНАЙ КОДИТЬ!)
/write-plan                        # Написать детальный план
/execute-plan                      # Выполнять пошагово с проверками
```

---

## 🏗️ Архитектура

```
~/.claude/
├── CLAUDE.md                      ← ГЛАВНЫЙ КОНФИГ (читается автоматически)
├── claude.json                    ← MCP серверы конфигурация
│
├── skills/                        ← Установленные скилы
│   ├── docx/
│   ├── pdf/
│   ├── xlsx/
│   ├── pptx/
│   ├── test-driven-development/
│   ├── code-reviewer/
│   ├── security-auditor/
│   └── [+ 33 скила...]
│
├── agents/                        ← 32 кастомных агента
│   ├── n8n-architect.md
│   ├── telegram-bot-dev.md
│   ├── python-dev.md
│   ├── sales-bot-designer.md
│   ├── ai-consultant-builder.md
│   └── [+ 27 агентов...]
│
└── plugins/                       ← Большие репозитории
    ├── superpowers/               (obra, 195k⭐, TDD framework)
    ├── superpowers-marketplace/
    ├── superpowers-skills/
    ├── superpowers-developing-for-claude-code/
    ├── claude-skills-main/        (alirezarezvani, 313 скилов)
    ├── composio-skills/           (automation integrations)
    ├── behisecc-skills/           (security & quality)
    └── glebis-skills/             (specialized)
```

---

## 🎯 Примеры использования

### Сценарий 1: Создание Telegram бота за 10 минут

```bash
claude

# В сессии Claude Code:

/brainstorm
"Мне нужен Telegram бот для каталога услуг дизайна.
- Каталог с пагинацией
- Заявка через FSM форму
- Платежи через LiqPay (украинский шлюз)
- Уведомления менеджеру
- Админ панель для редактирования каталога"

# После brainstorm (важно!):

/agent telegram-bot-dev
"Создай полный проект на aiogram 3.x с PostgreSQL на Railway.
Требования из браинсторма выше плюс:
- Webhook для обработки событий
- .env конфигурация
- Dockerfile для Railway
- README с инструкцией деплоя"

# Claude создаст всю структуру проекта

/skill test-driven-development
# Агент напишет тесты перед кодом

/skill code-reviewer
# Пересмотрит свой код перед деплоем

/agent devops-engineer
# Поможет развернуть на Railway
```

### Сценарий 2: n8n workflow для квалификации лидов

```bash
/agent n8n-architect
"Workflow в n8n:
1. Telegram webhook: пользователь пишет команду /apply
2. Бот спрашивает BANT вопросы (4 вопроса)
3. Система подсчитывает скор (0-100)
4. Если скор >= 70 → создать сделку в Bitrix24 + email менеджеру
5. Если скор < 70 → добавить в nurturing последовательность в Make.com
6. Уведомление в Slack о горячем лиде

Выведи JSON для импорта в n8n"

# Агент выдаст готовый JSON для импорта
# Скопируй в n8n: Import → Paste workflow
```

### Сценарий 3: RAG консультант на сайте

```bash
/agent ai-consultant-builder
"Построй полную RAG систему для FAQ сайта о каталогах PDF:
- Backend: FastAPI с pgvector на Railway
- Индексировать 50 страниц из каталога
- Frontend: React чат-виджет для встраивания
- Интеграция с Claude API для ответов
- Эскалация на менеджера если confidence < 0.6
- История диалогов в PostgreSQL

Выведи код в отдельные файлы готовый к деплою"

/agent frontend-dev
"Создай React компонент виджета для встраивания одной строкой:
<script src='https://твой-домен/widget.js'></script>"

/agent devops-engineer
"Railway деплой для backend и Vercel для фронта"
```

---

## 🔒 Безопасность и лучшие практики

### Включены скилы безопасности:
- ✅ **OWASP Top 10** проверки
- ✅ **Static Analysis** (CodeQL, Semgrep)
- ✅ **Secrets Management** (переменные окружения)
- ✅ **Rate Limiting** и throttling
- ✅ **SQL Injection** профилактика
- ✅ **JWT** безопасность

### Обязательные правила:
```
1. Никогда не хардкодить API ключи в коде
2. Использовать .env.example в репо
3. Railway Secrets для production
4. Активировать /security-auditor перед деплоем
5. Использовать HTTPS везде
```

---

## 📚 Топ-10 скилов для разных ситуаций

| Ситуация | Скил | Команда |
|----------|------|---------|
| Новая функция | test-driven-development | `/skill test-driven-development` |
| Code review | code-reviewer | `/skill code-reviewer` |
| Дизайн системы | senior-architect | `/skill senior-architect` |
| Уязвимости | security-auditor | `/skill security-auditor` |
| Оптимизация | performance-optimizer | `/skill performance-optimizer` |
| Документы Word | docx | `/skill docx` |
| PDF обработка | pdf | `/skill pdf` |
| Таблицы Excel | xlsx | `/skill xlsx` |
| Презентации | pptx | `/skill pptx` |
| UI компоненты | frontend-design | `/skill frontend-design` |

---

## 🔗 Основные репозитории

| Репозиторий | Звезды | Содержание |
|---|---|---|
| obra/superpowers | 195k+ | TDD, debugging, collaboration |
| anthropics/skills | 136k+ | Official: PDF, DOCX, XLSX, PPTX, design |
| alirezarezvani/claude-skills | 50k+ | 313 скилов для всех ролей |
| ComposioHQ/awesome-claude-skills | 20k+ | Automation & integrations |
| BehiSecc/awesome-claude-skills | 15k+ | Security & QA |
| glebis/claude-skills | 5k+ | Specialized (health, TTS, creative) |

---

## 🛠️ Расширенная настройка

### Добавить свой скил

```bash
mkdir -p ~/.claude/skills/my-custom-skill
cat > ~/.claude/skills/my-custom-skill/SKILL.md << 'EOF'
---
name: my-custom-skill
description: Что делает этот скил
---

# My Custom Skill

Инструкции для Claude...
EOF
```

### Добавить свой агент

```bash
cat > ~/.claude/agents/my-custom-agent.md << 'EOF'
---
name: my-custom-agent
description: Описание агента
tools: fetch, mcp__filesystem
---

# My Custom Agent

Роль и инструкции...
EOF
```

### Обновить все скилы

```bash
cd ~/.claude/plugins/superpowers && git pull
cd ~/.claude/plugins/claude-skills-main && git pull
cd ~/.claude/plugins/composio-skills && git pull
# и т.д.
```

---

## 📊 Статистика установки

```
После успешной установки:

✅ Плагины:        6 основных + маркетплейсы
✅ Скилы:          40+ production-ready
✅ Агенты:         32 кастомных специалиста
✅ MCP серверы:    10 интеграций
✅ Конфиги:        CLAUDE.md + claude.json

Всего компонентов: 88+
Размер установки:  ~2 GB (с node_modules)
Время установки:   ~3 минуты
Готовность:        Сразу после запуска claude
```

---

## ❓ FAQ

**Q: Что если я не получу API ключи?**  
A: Основной функционал работает без них. Только веб-поиск (Brave) будет недоступен.

**Q: Сколько стоит использование?**  
A: Бесплатно (кроме API вызовов). Brave Search, Supabase и ElevenLabs имеют щедрые free tier'ы.

**Q: Может ли я использовать только некоторые скилы?**  
A: Да, активируй нужные через `/skill <name>`. Остальные просто загружаются в фон.

**Q: Как обновить скилы?**  
A: `git pull` в папках плагинов (~/.claude/plugins/*/)

**Q: Работает ли с другими агентами (Cursor, Copilot)?**  
A: Большинство скилов работают везде, но лучше всего с Claude Code.

**Q: Можно ли использовать на Windows?**  
A: Да, если установлены git и WSL2.

---

## 📞 Поддержка

```bash
# Если что-то сломалось:
1. Проверь лог:
   echo $LAST_ERROR

2. Переустанови:
   rm -rf ~/.claude
   ./install-all-claude-code.sh

3. Сообщи об ошибке в репо:
   - https://github.com/obra/superpowers/issues
   - https://github.com/anthropics/skills/issues
```

---

## 🎓 Обучение

- **Superpowers документация:** https://github.com/obra/superpowers
- **Anthropic Skills docs:** https://docs.claude.com/en/docs/build-with-claude
- **Claude Code guide:** https://docs.claude.com
- **My Custom Agents:** ~/.claude/agents/

---

## 📄 Лицензии

- **Superpowers:** MIT (obra)
- **Anthropic Skills:** Apache 2.0
- **Community Skills:** Различные (см. репо)
- **Custom Agents:** Твои

---

## 📝 История версий

| Версия | Дата | Изменения |
|--------|------|-----------|
| 1.0.0 | May 2026 | Первый релиз с 88 компонентами |

---

**Создано для:** Сергей (n8n автоматизация, Telegram боты, AI консультанты, видео/фото генерация)  
**Совместимо с:** Claude Code 4.5+, OpenAI Codex, Cursor, Windsurf  
**Официальная поддержка:** https://github.com/obra/superpowers

---

## 🚀 Готов начать?

```bash
chmod +x install-all-claude-code.sh
./install-all-claude-code.sh

# После установки:
claude

# Первая команда всегда:
/brainstorm
```

**Good luck! 🎉**
