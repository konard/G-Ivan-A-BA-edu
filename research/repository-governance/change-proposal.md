# Черновик issue: изменения в репозитории по итогам исследования

Версия: 1

Дата среза: 25 мая 2026 г.

Связанная задача: [issue #13](https://github.com/G-Ivan-A/hybrid-Intelligence-lab/issues/13)

Этот файл — **готовый текст follow-up issue** на изменение репозитория
(пункт 3 задачи #13). Он хранится в репозитории для traceability и review.
Сама issue создана на основе этого текста:
[issue #15](https://github.com/G-Ivan-A/hybrid-Intelligence-lab/issues/15).
Изменения внедряются **после** подтверждения
[итогового видения](final-vision.md) Founder & PO и командами.

---

## Заголовок issue

`Привести структуру и операционный костяк hybrid-Intelligence-lab в соответствие с итоговым видением (issue #13)`

## Тело issue

### Контекст

По итогам исследования [research/repository-governance/](./) (сравнение
подходов команд C / Q / G + Вариант 4) согласовано итоговое видение
[final-vision.md](final-vision.md). Эта issue фиксирует конкретные изменения к
реализации. Подход — **operational backbone before taxonomy**: сначала
операционный костяк и дефекты, `/governance/`-layering — позже по триггеру.

### Scope изменений (приоритет 1 — сейчас)

#### FR-1. Привести имя репозитория `hybrid-Intelligence-lab`

Репозиторий переименован из `research-and-edu-ai-lab`. Обновить имя и URL в:

- `README.md` (строка с `research-and-edu-ai-lab`);
- `PRODUCT_VISION.md` (упоминания имени);
- `AI_GOVERNANCE.md` (упоминание имени);
- `docs/concept/repository-structure.md` и `docs/concept/vision-standard.md`
  (URL `https://github.com/G-Ivan-A/research-and-edu-ai-lab/...`).

Критерий готовности: `grep -rn "research-and-edu-ai-lab"` не находит совпадений
(кроме исторических ссылок, если они явно помечены как исторические).

#### FR-2. Завести `CHANGELOG.md`

Формат — как в `open-ai.ru`: date-based, секция `## Unreleased` с
`### Added` / `### Changed` / `### Removed`, блок `## TODO`. Первая запись
описывает изменения этой issue и исследование issue #13.

#### FR-3. Добавить `CONTRIBUTING.md`

GitHub-native точка входа контрибьютора со ссылками на `AI_GOVERNANCE.md`,
`docs/governance/hybrid-team-collaboration.md`, языковую политику и
`tests/validate-repository-structure.sh`. Не дублировать правила —
ссылаться на них.

#### FR-4. Добавить шаблоны задач `.github/` (синхр. с `open-ai.ru`)

- `.github/ISSUE_TEMPLATE/config.yml`;
- `.github/ISSUE_TEMPLATE/ai_implementation_task.yml` — адаптированный под
  research/edu hub (поля: Operating Mode, Context, Requirements, Allowed/
  Forbidden Changes, Acceptance Criteria, Language);
- `.github/ISSUE_TEMPLATE/research_task.md` — research mode (вопрос, метод,
  источники, ru/en);
- `.github/ISSUE_TEMPLATE/governance_change.md` — изменение правил/структуры;
- `.github/pull_request_template.md` — чек-лист из `hybrid-team-collaboration.md`.

#### FR-5. Исправить путь `experiments/tz-corpus`

`tz-corpus` относится исключительно к проекту Mango и не должен лежать в корне
`experiments/`. Перенести в проектный контекст Mango.

- Целевой путь: `experiments/mango/tz-corpus/` (каталог `experiments` остаётся,
  так как входит в финальную структуру; добавляется уровень проекта).
- Обновить ссылки: `research/mango/README.md`,
  `docs/concept/repository-structure.md`, скрипты с захардкоженными путями
  (`experiments/tz-corpus/...` в `README` и `build_html.py`/`extract_docx.py`,
  если есть).
- Обновить `tests/validate-repository-structure.sh` под новый путь.

Альтернатива (на согласование): `projects/mango/experiments/tz-corpus/`, если
Mango оформляется как проект. Рекомендуется `experiments/mango/tz-corpus/`,
чтобы сохранить отделение воспроизводимых экспериментов от исследовательского
текста (правило `research/README.md`).

#### FR-6. Добавить `LICENSE`

Выбор лицензии — решение Founder & PO (knowledge hub: рассмотреть CC-BY-4.0 для
текстов и/или MIT/Apache-2.0 для скриптов). Зафиксировать выбор в issue до
реализации.

### Scope изменений (приоритет 2 — по триггеру)

#### FR-7. Статусы зрелости артефактов

Ввести frontmatter `status:` (`draft` / `reviewed` / `published` /
`superseded`) и расширить `tests/validate-repository-structure.sh` проверкой
наличия/допустимости статуса. Формат frontmatter — см.
[final-vision.md](final-vision.md#содержание-артефактов-статусы-зрелости).

#### FR-8. `meta/artifact-map.md`

Завести реестр артефактов, когда число содержательных документов превысит порог
удобной ручной навигации (ориентир >15).

#### FR-9. `/governance/`-layering и переименование `AI_GOVERNANCE.md` → `GOVERNANCE.md`

Только при срабатывании триггера (≥3 специализированных политик одной области
или нечитаемый размер `AI_GOVERNANCE.md`). Делать одним согласованным
изменением, чтобы churn ссылок и валидатора был однократным.

### Что НЕ входит в scope

- Превращение репозитория в production-codebase.
- Тяжёлые enterprise-контракты.
- Преждевременное создание пустых `/governance/`-подкаталогов.

### Definition of Done

- [ ] FR-1…FR-6 реализованы; `tests/validate-repository-structure.sh` проходит.
- [ ] `CHANGELOG.md` содержит запись об изменениях.
- [ ] Навигация (`README.md`, README каталогов) обновлена.
- [ ] Нет совпадений `research-and-edu-ai-lab` (кроме явно исторических).
- [ ] `experiments/tz-corpus` отсутствует; новый путь зафиксирован и работает.
- [ ] FR-7…FR-9 запланированы с триггерами (не обязательно реализованы сразу).

### Метки / роли

- Метки: `governance`, `structure`, `needs-human-review`.
- Решение по лицензии и финальной структуре: Founder & PO.
- Реализация: AI agent в Structured-режиме по `AI_GOVERNANCE.md`.

---

## Связанные документы

- [comparison.md](comparison.md) — сравнение подходов команд C / Q / G + Вариант 4.
- [final-vision.md](final-vision.md) — итоговое видение для согласования.
- [README.md](README.md) — индекс исследования.
