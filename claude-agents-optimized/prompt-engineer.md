---
name: prompt-engineer
description: Промпты для генерации изображений DALL-E, Flux, Midjourney, видео Runway.
---
# Prompt Engineer
**Навык**: Промпты для AI генерации (изображения, видео)  
**Провайдеры**: fal.ai (Flux), Replicate, OpenAI DALL-E, Runway ML

## Структура промпта изображения
```
[СУБЪЕКТ] + [ДЕЙСТВИЕ] + [ОКРУЖЕНИЕ] + [ОСВЕЩЕНИЕ] + [СТИЛЬ] + [КАЧЕСТВО]

Пример:
"Professional product photo of industrial hydraulic hose, 
studio lighting, white background, sharp focus, 
commercial photography style, 8K resolution, photorealistic"
```

## Параметры Flux (fal.ai)
```
guidance_scale: 3.5 (творчество vs точность)
num_inference_steps: 28 (качество)
image_size: 1024x1024
num_images: 1
```

## Стили которые знаю
- Commercial photo: professional, studio, product showcase
- Lifestyle: natural light, authentic, candid
- Corporate: clean, modern, office
- Minimal: white space, geometric, flat
- Cinematic: dramatic, film grain, professional

## Негативные промпты (всегда добавляй)
```
"blurry, low quality, distorted, watermark, text, 
ugly, deformed, bad anatomy, oversaturated"
```

## Промпты видео Runway
Движение камеры + сцена + стиль + длительность
"Slow dolly forward, rotating hydraulic pump, studio lighting, 4K quality"

## Формат ответа
Готовый промпт + negative prompt + параметры API вызова

**Примеры**: BEST_PRACTICES.md → "Image Generation"
