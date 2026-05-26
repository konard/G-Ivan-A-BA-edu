# hybrid-Intelligence-lab

`hybrid-Intelligence-lab` - governance-first knowledge hub для исследований,
образования, стандартов, проектных knowledge bases и управляемой работы
гибридных human + AI команд.

Репозиторий не является production-кодовой базой. Production-системы,
клиентские реализации и приложения с собственным жизненным циклом должны жить
в отдельных spoke-репозиториях и ссылаться сюда как на источник переиспользуемых
знаний и правил работы.

## Ключевые документы

| Документ | Назначение |
| --- | --- |
| [CONCEPT.md](CONCEPT.md) | Актуальная концепция репозитория, аудитории, границы и модель hub-and-spoke. |
| [AI_GOVERNANCE.md](AI_GOVERNANCE.md) | Операционный контракт для Founder & PO, reviewers, contributors и AI-агентов. |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Правила участия, локальные проверки и ожидания к review. |
| [CHANGELOG.md](CHANGELOG.md) | Date-based журнал governance-изменений репозитория. |
| [LICENSE](LICENSE) | Текущий статус лицензии и pending-решение Founder & PO. |
| [standards/README.md](standards/README.md) | Таблица активных и планируемых стандартов. |
| [standards/GLOSSARY.md](standards/GLOSSARY.md) | Единый словарь терминов для standards, governance и AI-assisted work. |
| [governance/REPO_MODEL.md](governance/REPO_MODEL.md) | Модель структуры репозитория и Anti-Inflation правило. |

## Структура

| Путь | Роль |
| --- | --- |
| `standards/` | Плоский реестр стандартов, шаблонов и правил оформления артефактов. |
| `research/` | Исследования по доменам и source-backed анализ. |
| `frameworks/` | Методологии, создаваемые только после доказанного gap с существующими подходами. |
| `projects/` | Project knowledge bases, промпты, процессы и контекст spoke-репозиториев. |
| `education/` | Open education: программы, учебные материалы и сценарии занятий. |
| `governance/` | Модель репозитория, операционные решения и сквозные governance-правила. |
| `tools/` | Локальные проверки и служебные скрипты сопровождения репозитория. |
| `.github/ISSUE_TEMPLATE/` | GitHub-native структура постановки задач. |

## Состояние миграции

Файлы предыдущей структуры сохранены с суффиксом `-old` для анализа и
выборочного переноса ценного содержания. Они являются историческими входами,
а не активным контрактом репозитория.

Новые артефакты добавляются только тогда, когда решают операционную проблему,
и должны ссылаться на ближайший стандарт или governance-правило.

## Локальная проверка

```bash
./tools/validate-repository-structure.sh
```
