# Claude Code Pro Setup — Быстрый старт

## 🚀 Установка (1 команда)

```bash
chmod +x install-all-claude-code.sh
./install-all-claude-code.sh
```

**Что устанавливается:**
- ✅ **Superpowers** (195k+ ⭐) — TDD, debugging, collaboration
- ✅ **Anthropic Official Skills** — PDF, DOCX, XLSX, PPTX, дизайн
- ✅ **313+ инженерных скилов** (alirezarezvani)
- ✅ **Automation & Integration** (ComposioHQ)
- ✅ **Security & Quality** (BehiSecc)
- ✅ **Specialized Skills** (glebis) — health, TTS, creative
- ✅ **32 кастомных агента** (Sergey's Stack)
- ✅ **10 MCP серверов** для расширения возможностей

**Время установки:** ~3 минуты

---

## 📋 Первые шаги

### 1. Получи API ключи (нужны для полного функционала)

```bash
# Brave Search (веб-поиск в агентах)
→ https://api.search.brave.com
  Free: 2000 запросов в месяц
  Переменная: BRAVE_API_KEY

# Supabase (база данных для ботов)
→ https://supabase.com
  Free tier: 500 MB, 50k операций/мес
  Переменные: SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY

# ElevenLabs (озвучка для видео)
→ https://elevenlabs.io
  Free: 10k символов в месяц
  Переменная: ELEVENLABS_API_KEY (опционально)
```

### 2. Обновь конфиг с ключами

```bash
nano ~/.claude/claude.json
```

Найди строки с `ВСТАВЬ_КЛЮЧ` и замени на реальные значения

### 3. Запусти Claude Code

```bash
claude
```

---

## 🎯 Твои 32 агента (готовые к использованию)

### Автоматизации (n8n / Make)
```bash
/agent n8n-architect
  "создай workflow: Telegram → анкета → CRM → уведомление менеджеру"

/agent make-builder
  "построй сценарий Make для автоматизации Airtable → Email"

/agent webhook-engineer
  "спроектируй webhook-систему для обработки платежей от Stripe"

/agent api-integrator
  "напиши клиент для интеграции с амоCRM API"

/agent data-transformer
  "преобразуй CSV в JSON и загрузи в PostgreSQL"
```

### Telegram боты и продажи
```bash
/agent telegram-bot-dev
  "создай бота для продажи с FSM формами и платежами"

/agent sales-bot-designer
  "спроектируй диалоговую воронку: захват → квалификация → закрытие"

/agent ai-consultant-builder
  "построй RAG-консультанта с базой знаний из PDF каталога"

/agent lead-qualifier
  "создай систему квалификации лидов по BANT методологии"

/agent support-agent
  "разработай чат-поддержку с эскалацией на живого оператора"
```

### Контент и маркетинг
```bash
/agent copywriter
  "напиши продающий пост в Telegram и email цепочку"

/agent image-pipeline
  "создай пайплайн: промпт → fal.ai → Cloudinary → URL"

/agent video-director
  "напиши сценарий для Runway ML: рекламный ролик 30 сек"

/agent content-strategist
  "разработай контент-план на месяц с графиком публикаций"

/agent email-marketer
  "создай welcome-серию из 5 писем для новых подписчиков"
```

### Разработка
```bash
/agent python-dev
  "напиши FastAPI backend для AI консультанта с PostgreSQL"

/agent frontend-dev
  "создай Next.js widget для встраивания на сайт"

/agent devops-engineer
  "настрой деплой на Railway с GitHub Actions CI/CD"

/agent database-architect
  "спроектируй PostgreSQL схему с pgvector для embeddings"

/agent code-reviewer
  "проверь код на ошибки, безопасность и best practices"
```

### Бизнес и аналитика
```bash
/agent business-analyst
  "напиши ТЗ для Telegram бота с user stories и acceptance criteria"

/agent data-analyst
  "проанализируй конверсию воронки продаж и дай рекомендации"

/agent market-researcher
  "исследуй рынок: конкуренты, аудитория, positioning"

/agent project-manager
  "разбей проект на спринты с оценками и зависимостями"

/agent qa-tester
  "напиши тест-кейсы и автотесты на Playwright"
```

---

## 📚 Лучшие скилы для каждой задачи

### Разработка
```bash
/skill test-driven-development     # TDD: Red-Green-Refactor
/skill code-reviewer               # Code review & refactoring
/skill senior-architect            # System design & architecture
/skill performance-optimizer       # Performance & optimization
/skill security-auditor            # Security review & OWASP checks
```

### Документы и контент
```bash
/skill docx                        # Word документы
/skill pdf                         # PDF: извлечение, слияние, аннотации
/skill xlsx                        # Excel таблицы и формулы
/skill pptx                        # PowerPoint презентации
/skill frontend-design             # UI/UX дизайн и компоненты
```

### Специальное
```bash
/skill owasp-security              # OWASP Top 10 + ASVS 5.0
/skill debug-skill                 # Реальный дебаггер с breakpoints
/skill kanban-skill                # Markdown Kanban доска
/skill linear-claude-skill         # Linear issue tracking
/skill qa-tester                   # Тестирование Playwright
```

---

## 🔧 Примеры использования

### Пример 1: Создание Telegram бота с продажами за 10 минут

```bash
claude

# В Claude Code session:

/agent telegram-bot-dev
"Нужен Telegram бот для каталога услуг UI дизайна.
Функции:
- /start — главное меню
- /catalog — каталог с пагинацией
- /order — форма заявки (FSM)
- Уведомления менеджеру в приватный чат
Stack: aiogram 3.x, PostgreSQL, Railway"

# Claude создаст всю структуру проекта с кодом
# Потом используй devops-engineer для деплоя
```

### Пример 2: n8n workflow для квалификации лидов

```bash
/agent n8n-architect
"Создай workflow в n8n:
Вход: Telegram сообщение
1. Спроси вопросы BANT (через бота)
2. Посчитай скор (70+ = горячий)
3. Если горячий → создай сделку в Bitrix24
4. Если холодный → добавь в nurturing цепочку в Make
5. Уведомление менеджеру в Slack"

# Агент выдаст JSON для импорта в n8n
```

### Пример 3: RAG консультант для сайта

```bash
/agent ai-consultant-builder
"Построй RAG-систему для FAQ сайта:
1. Индексировать 50 страниц из CatalogIQ
2. FastAPI backend с pgvector поиском
3. React виджет для встраивания
4. Эскалация на менеджера если confidence < 0.6
Stack: FastAPI, Next.js, Supabase, Claude API"

# Получишь готовый backend + frontend
```

---

## ⚡ Полезные команды Claude Code

```bash
/plugin list                       # Список установленных плагинов
/plugin install <name>             # Установить плагин
/skill list                        # Список скилов
/skill <name>                      # Активировать скил
/agent list                        # Список агентов
/agent <name>                      # Использовать агента

# Superpowers команды
/brainstorm                        # Сессия планирования (ОБЯЗАТЕЛЬНО перед кодом!)
/write-plan                        # Написать план реализации
/execute-plan                      # Выполнить план пошагово
/test-driven-development           # Режим TDD
```

---

## 📁 Где всё находится

```
~/.claude/
├── CLAUDE.md                      # Глобальный профиль (ГЛАВНЫЙ)
├── claude.json                    # MCP конфигурация
├── skills/                        # 40+ установленных скилов
│   ├── docx/
│   ├── pdf/
│   ├── test-driven-development/
│   └── [+ ещё 37...]
├── agents/                        # 32 кастомных агента
│   ├── n8n-architect.md
│   ├── telegram-bot-dev.md
│   └── [+ ещё 30...]
└── plugins/                       # Большие репозитории плагинов
    ├── superpowers/               # (195k+ ⭐)
    ├── superpowers-marketplace/
    ├── claude-skills-main/        # (313+ скилов)
    ├── composio-skills/
    └── behisecc-skills/
```

---

## 🔗 Источники и репозитории

| Репо | ⭐ | Что дает |
|------|-----|---------|
| **obra/superpowers** | 195k+ | TDD, debugging, collaboration |
| **anthropics/skills** | 136k+ | Official: PDF, DOCX, XLSX, PPTX, дизайн |
| **alirezarezvani/claude-skills** | 50k+ | 313 скилов для инженеров и маркетологов |
| **ComposioHQ/awesome-claude-skills** | 20k+ | Automation & workflow интеграции |
| **BehiSecc/awesome-claude-skills** | 15k+ | Security, testing, code quality |
| **glebis/claude-skills** | 5k+ | Health, TTS, creative skills |

---

## 🛟 Помощь и поддержка

```bash
# Ошибка? Проверь лог:
echo $LAST_ERROR

# Обнови скилы:
cd ~/.claude/plugins/superpowers && git pull

# Перейти на ветку с новыми скилами:
cd ~/.claude/plugins/claude-skills-main && git checkout main && git pull

# Сбросить всё к дефолту:
rm -rf ~/.claude
./install-all-claude-code.sh
```

---

## 📊 Статистика установки

После запуска скрипта ты получаешь:

```
✓ 40+ скилов (документы, дизайн, тестирование, безопасность)
✓ 6 основных плагинов (Superpowers, Composio, Security, и др.)
✓ 32 кастомных агента (автоматизация, боты, контент, разработка)
✓ 10 MCP серверов (файлы, браузер, поиск, БД, память)
✓ Готовые примеры и конфигурация

Total setup time: ~3 минуты
Total installed: 88+ компонентов
Ready to use: Сразу после получения API ключей
```

---

## 💡 Советы для максимальной продуктивности

1. **Всегда начинай с /brainstorm** — спланируй перед кодом
2. **Используй правильный агент** — не проси фронтенд-дева писать n8n workflow
3. **Activируй скилы явно** — `/skill code-reviewer` при ревью
4. **Сохраняй конфиги** — git add ~/.claude/{CLAUDE.md,claude.json}
5. **Обновляй скилы** — еженедельно pull на репозиториях
6. **Экспериментируй** — пробуй новые скилы из awesome-lists

---

**Версия:** 1.0.0 (May 2026)  
**Совместимо с:** Claude Code 4.5+, OpenAI Codex, Cursor, Windsurf  
**Последнее обновление:** May 20, 2026
