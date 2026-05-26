---
status: canonical
version: 1.0
updated: 2026-05-26
ai-generated: false
---

# Concept

Версия: 1.0

Дата: 2026-05-26

Этот документ собирает предыдущие материалы о структуре репозитория,
governance-исследовании и operational backbone в короткий активный контракт для
`hybrid-Intelligence-lab`.

## Назначение

Репозиторий является центральным knowledge hub для предсказуемой работы
гибридных human + AI команд. Он хранит переиспользуемые знания рядом с
governance: исследования, образование, стандарты, методологии, проектный
контекст и правила работы AI должны быть обнаружимыми, проверяемыми и
traceable.

## Аудитории

| Аудитория | Ценность репозитория |
| --- | --- |
| Founder & PO | Управляемая карта исследований, методологии, обучения и проектного контекста. |
| Reviewers и support teams | Единые правила размещения, review-критерии и lightweight standards. |
| Researchers | Доменные research areas с явными источниками, методом, ограничениями и правилами публикации. |
| Educators | Open education материалы, которые могут ссылаться на общие стандарты и исследования. |
| AI agents | Ограниченный контекст, явные operating rules и проверяемые задачи. |
| Production teams | Переиспользуемые знания без переноса production lifecycle в этот репозиторий. |

## Принципы

| Принцип | Смысл |
| --- | --- |
| Governance before scale | Структура и review-правила фиксируются до роста артефактов. |
| Separation of concerns | Research, education, frameworks, projects, standards и governance имеют разные дома. |
| Existing frameworks first | Новый framework появляется только после сравнения и выявленного gap. |
| Traceability | Важные утверждения связаны с issue, PR, источниками, экспериментами или прежними артефактами. |
| Operating Mode | Работа ведется в structured mode по умолчанию; creative mode используется только там, где задача явно требует исследовательской генерации вариантов. |
| Human-in-control | AI может готовить черновики и проверки, но решения остаются за Founder & PO и reviewers. |
| Safe publication | Secrets, клиентский sensitive context и несанитизированные production-промпты не публикуются. |
| Anti-Inflation | Артефакт добавляется только при операционной боли, которую он снижает. |

## Модель репозитория

Выбрана модель central knowledge hub + spoke projects:

- hub хранит переиспользуемые методы, стандарты, исследования, обучение,
  проектный контекст и governance;
- spokes хранят production-код, клиентскую delivery-логику, приложения и
  инициативы с собственным release lifecycle;
- ссылки из spokes в hub должны вести на стабильные standards, governance
  rules и reviewed knowledge artifacts.

Операционная модель структуры зафиксирована в
[governance/REPO_MODEL.md](governance/REPO_MODEL.md).

## Границы

Репозиторий включает:

- стандарты и шаблоны knowledge artifacts;
- доменные исследования и воспроизводимый контекст;
- образовательные программы и учебные материалы;
- framework proposals и описания методик;
- project knowledge bases, prompts и process context;
- governance-правила для human + AI collaboration.

Репозиторий не должен становиться:

- монолитной production-codebase;
- складом несвязанных заметок;
- местом хранения secrets или private client data;
- местом, где AI-generated drafts обходят human review.

## Связанные контракты

| Документ | Роль |
| --- | --- |
| [README.md](README.md) | Точка входа и навигация. |
| [AI_GOVERNANCE.md](AI_GOVERNANCE.md) | Правила AI-assisted work. |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contribution workflow и PR expectations. |
| [standards/README.md](standards/README.md) | Реестр standards и инструкция применения. |
| [governance/REPO_MODEL.md](governance/REPO_MODEL.md) | Правила структуры и Anti-Inflation. |
| `TEAM_CONTRACT.md` | Шаблон командного соглашения для spoke-проектов; не является активным контрактом этого репозитория, пока файл не создан и не принят review. |
| [standards/GLOSSARY.md](standards/GLOSSARY.md) | Canonical источник единой терминологии для standards, governance и AI-assisted work. |

## Стандарты

Активные и планируемые стандарты перечислены в
[standards/README.md](standards/README.md). При создании или переносе артефакта
сначала используется ближайший стандарт. Если стандарта нет, артефакт остается
минимальным, а missing standard фиксируется как follow-up вместо немедленного
создания большой taxonomy.

## Правило миграции

Файлы с суффиксом `-old` сохранены для анализа. Ценное содержание переносится
в новую структуру только через reviewable changes, которые ссылаются на
source file и объясняют, почему содержание остается операционно полезным.
