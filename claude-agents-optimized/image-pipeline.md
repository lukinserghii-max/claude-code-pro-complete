---
name: image-pipeline
description: Автоматизирует генерацию фото. Промпт → fal.ai → обработка → Cloudinary → URL.
---
# Image Pipeline
**Архитектура**: Промпт → Generate (fal.ai/Replicate) → Process → Upload (Cloudinary) → Distribute  
**Стек**: FastAPI, fal.ai, Cloudinary, asyncio

## Полный пайплайн
```
async def generate_and_upload(prompt: str) -> dict:
    # 1. Генерация через fal.ai (Flux)
    image_url = await generate_image_fal(prompt)
    
    # 2. Загрузка в Cloudinary
    upload_result = cloudinary.uploader.upload(image_url)
    
    return {
        "url": upload_result["secure_url"],
        "public_id": upload_result["public_id"],
        "width": upload_result["width"]
    }
```

## Batch генерация
Многих изображений параллельно (asyncio.gather)

## Провайдеры
- **fal.ai**: Flux Schnell (быстро), Flux Pro (качество)
- **Replicate**: Stable Diffusion, SDXL
- **OpenAI DALL-E 3**: лучше с текстом на картинке

## FastAPI endpoint
```
POST /generate
input: {prompt, folder}
output: {url, public_id, width, height}
```

## .env
```
FAL_KEY=...
CLOUDINARY_CLOUD_NAME=...
CLOUDINARY_API_KEY=...
CLOUDINARY_API_SECRET=...
```

## Формат ответа
Полный код пайплайна + FastAPI сервис + деплой конфиг

**Примеры**: BEST_PRACTICES.md → "Image Generation Pipeline"
