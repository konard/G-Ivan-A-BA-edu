# Changelog

All notable repository governance changes are documented here.

## Unreleased

### Added

- Canonical education project profile в `standards/EDUCATION_PROFILE.md` для
  структуры курсов, модулей, уроков, упражнений и адаптации под open,
  commercial и internal learning formats.
- Canonical glossary в `standards/GLOSSARY.md` для единых терминов standards,
  governance и AI-assisted work.
- Issue #17 migration structure: `CONCEPT.md`, обновленные root governance
  files, `standards/README.md`, `governance/REPO_MODEL.md` и `tools/`.
- Repository structure validation в `tools/validate-repository-structure.sh`.
- Active documentation для Anti-Inflation principle: артефакт создается только
  когда снижает операционную боль.
- Issue #31: `standards/RESEARCH_PROFILE.md` — canonical профиль
  исследовательских проектов (именование `YYYY-MM-topic.md`, frontmatter
  исследований, организация экспериментов `exp-<slug>/`, чек-лист публикации и
  цитируемые best practices). Зарегистрирован как active в `standards/README.md`
  и проверяется в `tools/validate-repository-structure.sh`.
- `standards/PRODUCT_PROFILE.md` (issue #29): профиль для продуктовых проектов
  с обязательными артефактами, шаблоном `PRODUCT_VISION.md` и матрицей
  адаптации по стадиям MVP / Pilot / Production; зарегистрирован в реестре
  standards и в structure validation.
- `standards/TEAM_CONTRACT.md` как шаблон и инструкция для создания
  project-level `CONTRIBUTING.md` и `AI_GOVERNANCE.md` в spoke-проектах.

### Changed

- Previous tracked files сохранены с суффиксом `-old` для анализа и выборочной
  миграции.
- Active navigation теперь указывает на `governance/` вместо `meta/` и на
  `tools/` вместо `tests/`.
- Standards рассматриваются как плоский registry, пока operational use не
  докажет потребность в более глубокой taxonomy.

### Removed

- Old content не удалялся в этой миграции; previous files были переименованы
  для review.

## Связанные документы

- [README.md](README.md)
- [CONCEPT.md](CONCEPT.md)
- [AI_GOVERNANCE.md](AI_GOVERNANCE.md)
- [CONTRIBUTING.md](CONTRIBUTING.md)
- [standards/README.md](standards/README.md)
- [standards/GLOSSARY.md](standards/GLOSSARY.md)
- [standards/EDUCATION_PROFILE.md](standards/EDUCATION_PROFILE.md)
- [standards/TEAM_CONTRACT.md](standards/TEAM_CONTRACT.md)
- [governance/REPO_MODEL.md](governance/REPO_MODEL.md)

## TODO

- Проанализировать `-old` files и перенести только содержание, которое остается
  операционно полезным.
- Добавить concrete artifact templates после появления повторяющихся работ и
  стабильных потребностей.
- Заменить license placeholder после решения Founder & PO.
