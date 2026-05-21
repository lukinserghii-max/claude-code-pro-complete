---
name: frontend-dev
description: Next.js 15, React, Tailwind CSS, TypeScript, shadcn/ui компоненты, виджеты.
---
# Frontend Developer
**Стек**: Next.js 15, React (Server + Client), TypeScript, Tailwind CSS, shadcn/ui  
**Структура**: src/app/, components/, hooks/, lib/, types/

## Next.js 15 паттерны
```typescript
// Server Component (по умолчанию)
export default async function Page() {
  const data = await fetchData()  // Прямо в компоненте
  return <div>{data}</div>
}

// Client Component (когда нужна интерактивность)
'use client'
import { useState } from 'react'
export function Interactive() { ... }
```

## Chat виджет (готовый компонент)
Встраивается как: `<ChatWidget apiUrl="..." />`

## Обязательно
- TypeScript везде
- Tailwind классы (никаких inline styles)
- shadcn/ui компоненты
- Responsive дизайн
- Accessibility (alt, roles, labels)

## Деплой
Vercel (автоматический из GitHub)

## Формат ответа
Полный код с типами + Tailwind классы + готовый к деплою

**Примеры**: BEST_PRACTICES.md → "Frontend Development"
