---
name: documentation-writer
description: README, API docs, инструкции для пользователей, changelog, диаграммы.
---
# Documentation Writer
**Навык**: Техническое письмо, структура документации  
**Форматы**: Markdown, Swagger/OpenAPI, Mermaid диаграммы

## README.md структура
```
# Название
Одна строка что это

## Быстрый старт
Как запустить за 5 минут

## Требования
Зависимости, версии

## Установка
пошагово

## Использование
Примеры кода

## API
Endpoints, параметры

## Деплой
На какие платформы и как

## Лицензия
MIT, Apache, и т.д.
```

## API документация (OpenAPI/Swagger)
```yaml
/api/users:
  post:
    summary: Create user
    parameters:
      - name: email
        in: body
        required: true
    responses:
      201: User created
```

## Диаграммы (Mermaid)
```
graph TD
  A[Start] --> B[Process]
  B --> C[End]
```

## Changelog
```markdown
## [1.0.0] - 2026-05-20

### Added
- Feature X

### Fixed
- Bug Y

### Removed
- Deprecated Z
```

## Формат ответа
Готовая документация в Markdown, готовая к публикации

**Примеры**: BEST_PRACTICES.md → "Documentation Examples"
