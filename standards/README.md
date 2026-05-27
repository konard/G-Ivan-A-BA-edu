# Standards

Каталог является плоским реестром активных и планируемых стандартов. Более
глубокая структура добавляется только после повторяющегося использования, когда
плоский реестр становится операционно неудобным.

## Реестр

| Стандарт | Статус | Где применяется | Источник |
| --- | --- | --- | --- |
| Единый глоссарий терминов | Active | Issues, standards, governance, AI-assisted work | [standards/GLOSSARY.md](GLOSSARY.md) |
| Правила именования файлов | Active | Research, standards, experiments, profiles и education artifacts | [standards/FILE_NAMING.md](FILE_NAMING.md) |
| Education project profile | Active | `education/{course}/`, course materials, workshops и учебная документация | [standards/EDUCATION_PROFILE.md](EDUCATION_PROFILE.md) |
| Концепция репозитория | Active | Root concept и назначение репозитория | [CONCEPT.md](../CONCEPT.md) |
| AI governance contract | Active | AI-assisted issues, PRs и reviews | [AI_GOVERNANCE.md](../AI_GOVERNANCE.md) |
| Repository model | Active | Размещение артефактов и правила создания | [governance/REPO_MODEL.md](../governance/REPO_MODEL.md) |
| Профиль исследовательских проектов | Active | `research/<domain>/` | [RESEARCH_PROFILE.md](RESEARCH_PROFILE.md) |
| Product profile | Active | Продуктовые spoke-проекты (ПО, сервис, услуга) | [PRODUCT_PROFILE.md](PRODUCT_PROFILE.md) |
| Team contract template | Active | Создание project-level `CONTRIBUTING.md` и `AI_GOVERNANCE.md` для spoke-проектов | [TEAM_CONTRACT.md](TEAM_CONTRACT.md) |
| Жизненный цикл задач | Active | Issues, PRs, переходы статусов, AI-assisted task execution | [ISSUE_WORKFLOW.md](ISSUE_WORKFLOW.md) |
| PROJECT_STRUCTURE_INHERITANCE.md | Active | Правило наследования структуры каталогов в проектах; обязательно для новых проектов | [PROJECT_STRUCTURE_INHERITANCE.md](PROJECT_STRUCTURE_INHERITANCE.md) |
| Research report | Planned | `research/<domain>/` | Создать после повторяющихся research tasks. |
| Framework proposal | Planned | `frameworks/` | Создать после documented framework gap. |
| Project knowledge base | Planned | `projects/` | Создать после повторяющейся потребности в project context. |
| Artifact lifecycle | Planned | Все reviewed artifacts | Создать, когда maturity states станут операционно необходимы. |

## Как пользоваться

1. Определите тип артефакта и целевой каталог по
   [governance/REPO_MODEL.md](../governance/REPO_MODEL.md). Для навигации по
   существующим артефактам и их связям используйте
   [governance/ARTIFACT_MAP.md](../governance/ARTIFACT_MAP.md).
2. Выберите имя файла или каталога по
   [standards/FILE_NAMING.md](FILE_NAMING.md).
3. Проверьте терминологию по [standards/GLOSSARY.md](GLOSSARY.md), если
   документ вводит governance, lifecycle или AI-assisted work terms.
4. Для образовательных материалов используйте
   [standards/EDUCATION_PROFILE.md](EDUCATION_PROFILE.md) до создания курса,
   воркшопа или учебной документации.
5. Используйте active standard из таблицы, если он уже есть.
6. Если standard planned, но еще не active, держите артефакт минимальным и
   объясните gap в issue или PR.
7. Не добавляйте новый standard только потому, что документ можно
   стандартизировать. Добавляйте его, когда повторяющаяся работа создает
   реальную coordination или review problem.
8. Ссылайтесь на новый active standard из этой таблицы и ближайшего README или
   governance document.
