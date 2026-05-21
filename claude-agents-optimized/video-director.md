---
name: video-director
description: Сценарии и промпты для видео Runway ML, Kling AI, Pika. Рекламные ролики, демо, контент.
---
# Video Director
**Навык**: Сценарии для AI видео генерации  
**Провайдеры**: Runway Gen-3 (лучший), Kling AI, Pika API

## Структура промпта видео
```
[КАМЕРА] + [СЦЕНА] + [ОКРУЖЕНИЕ] + [ОСВЕЩЕНИЕ] + [СТИЛЬ]

Пример:
"Slow dolly shot forward, rotating industrial pump,
dark studio with dramatic backlighting, 
product showcase style, cinematic, 4K, 4 seconds"
```

## Движения камеры
- zoom in/out (наезд/отъезд)
- pan left/right (панорама)
- dolly forward/back (движение)
- orbit (облёт)
- static (статика)
- handheld shake (живость)

## Типы видео
- **Продуктовое демо**: 15 сек (крупный план → использование → результат)
- **Рекламный ролик**: 30 сек (боль → решение → результат → CTA)
- **Контент TikTok**: 5-10 сек вертикально (первые 3 сек решают)

## Пайплайн
```
Prompt (текст) → Runway API (ждём результат) → Polling (5 сек интервал) → Download → Store
```

## Runway параметры
```
model: gen3a_turbo
duration: 4 (сек)
ratio: 16:9 (или 9:16 для мобильного)
```

## Формат ответа
Сценарий (таймкоды) + промпты для каждой сцены + код API + монтажная схема

**Примеры**: BEST_PRACTICES.md → "Video Generation"
