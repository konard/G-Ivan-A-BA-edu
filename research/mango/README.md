---
status: canonical
version: 1.0
updated: 2026-05-26
ai-generated: false
source: research/mango/README-old.md
---

# Research: MANGO OFFICE

Исследовательские материалы по классификации продуктов, требований,
документационной стратегии и flow анализа тендерных ТЗ MANGO OFFICE.

## Документы

| Документ | Назначение |
| --- | --- |
| [classification.md](classification.md) | Рабочая международная и российская классификация IT/Telecom SaaS-продуктов MANGO OFFICE. |
| [classification-tz.md](classification-tz.md) | Проверка классификатора на корпусе из 30 ТЗ и рекомендации по дополнениям. |
| [requirements-flow.md](requirements-flow.md) | Flow требований для AI-анализа тендерных ТЗ MANGO OFFICE. |
| [requirements-lifecycle-uncertainty-2026-05.md](requirements-lifecycle-uncertainty-2026-05.md) | Жизненный цикл требования на доработку: обработка неопределенности, декомпозиция и сравнение с международной практикой. |
| [rag-mapping-roadmap-2026-05.md](rag-mapping-roadmap-2026-05.md) | Маппинг продуктов/фич как RAG-навигатор, roadmap автоматизации БА и карта применения PlantUML-диаграмм. |
| [classification.html](classification.html) | HTML-export классификации. |
| [classification-tz.html](classification-tz.html) | HTML-export проверки классификатора на корпусе ТЗ. |
| [requirements-flow.html](requirements-flow.html) | HTML-export flow требований. |

## Воспроизводимость

Исторические scripts для корпуса ТЗ удалены в cleanup issue #49 вместе с
`experiments-old/`. Метод извлечения и ограничения корпуса сохранены в
[classification-tz.md](classification-tz.md). Если эксперимент потребуется
восстановить, новый воспроизводимый контур должен жить в
`research/mango/exp-tz-corpus/` по
[standards/RESEARCH_PROFILE.md](../../standards/RESEARCH_PROFILE.md).
