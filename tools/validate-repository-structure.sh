#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

failures=0

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  failures=$((failures + 1))
}

require_dir() {
  local path="$1"
  [[ -d "$path" ]] || fail "missing directory: $path"
}

require_file() {
  local path="$1"
  [[ -f "$path" ]] || fail "missing file: $path"
}

require_text() {
  local path="$1"
  local text="$2"
  if [[ -f "$path" ]] && ! grep -Fq "$text" "$path"; then
    fail "$path must contain: $text"
  fi
}

is_active_file() {
  case "$1" in
    README.md | \
    CONCEPT.md | \
    CONTRIBUTING.md | \
    AI_GOVERNANCE.md | \
    CHANGELOG.md | \
    LICENSE | \
    standards/README.md | \
    standards/FILE_NAMING.md | \
    standards/RESEARCH_PROFILE.md | \
    standards/GLOSSARY.md | \
    standards/EDUCATION_PROFILE.md | \
    standards/PRODUCT_PROFILE.md | \
    standards/TEAM_CONTRACT.md | \
    standards/ISSUE_WORKFLOW.md | \
    standards/PROJECT_STRUCTURE_INHERITANCE.md | \
    research/mango/taxonomy-concept-2026-05.md | \
    research/mango/requirements-lifecycle-uncertainty-2026-05.md | \
    research/mango/rag-mapping-roadmap-2026-05.md | \
    research/mango/capability-decomposition-2026-05.md | \
    research/README.md | \
    research/mango/README.md | \
    research/mango/classification.md | \
    research/mango/classification.html | \
    research/mango/classification-tz.md | \
    research/mango/classification-tz.html | \
    research/mango/requirements-flow.md | \
    research/mango/requirements-flow.html | \
    frameworks/README.md | \
    education/README.md | \
    projects/README.md | \
    projects/mango/README.md | \
    projects/mango/experiments/user-story_gen-from-raw-request_2026-05-26.md | \
    projects/mango/experiments/tz-stats-prototype-2026-05.md | \
    projects/mango/prompts/user-story-generator_exp-2026-05.md | \
    projects/mango/standards/classification-glossary.md | \
    projects/mango/kb/.gitkeep | \
    projects/mango/prompts/.gitkeep | \
    projects/mango/docs/.gitkeep | \
    projects/mango/experiments/.gitkeep | \
    projects/mango/decisions/.gitkeep | \
    projects/education-ba-prompt/README.md | \
    projects/education-ba-prompt/docs/course-ideas.md | \
    projects/repo-development/README.md | \
    projects/repo-development/docs/migration-audit-2026-05.md | \
    governance/REPO_MODEL.md | \
    governance/ARTIFACT_MAP.md | \
    .github/ISSUE_TEMPLATE/task.yml | \
    tools/validate-frontmatter.sh | \
    tools/validate-repository-structure.sh)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

is_old_file() {
  local name="${1##*/}"
  [[ "$name" == *-old || "$name" == *-old.* ]]
}

required_directories=(
  ".github/ISSUE_TEMPLATE"
  "standards"
  "research"
  "frameworks"
  "projects"
  "projects/mango/standards"
  "projects/mango/kb"
  "projects/mango/prompts"
  "projects/mango/docs"
  "projects/mango/experiments"
  "projects/mango/decisions"
  "education"
  "governance"
  "tools"
)

required_files=(
  "README.md"
  "CONCEPT.md"
  "CONTRIBUTING.md"
  "AI_GOVERNANCE.md"
  "CHANGELOG.md"
  "LICENSE"
  "standards/README.md"
  "standards/FILE_NAMING.md"
  "standards/RESEARCH_PROFILE.md"
  "standards/GLOSSARY.md"
  "standards/EDUCATION_PROFILE.md"
  "standards/PRODUCT_PROFILE.md"
  "standards/TEAM_CONTRACT.md"
  "standards/ISSUE_WORKFLOW.md"
  "standards/PROJECT_STRUCTURE_INHERITANCE.md"
  "research/README.md"
  "research/mango/README.md"
  "research/mango/classification.md"
  "research/mango/classification.html"
  "research/mango/classification-tz.md"
  "research/mango/classification-tz.html"
  "research/mango/requirements-flow.md"
  "research/mango/requirements-flow.html"
  "research/mango/rag-mapping-roadmap-2026-05.md"
  "frameworks/README.md"
  "education/README.md"
  "projects/README.md"
  "projects/mango/README.md"
  "projects/mango/experiments/user-story_gen-from-raw-request_2026-05-26.md"
  "projects/mango/experiments/tz-stats-prototype-2026-05.md"
  "projects/mango/prompts/user-story-generator_exp-2026-05.md"
  "projects/mango/standards/classification-glossary.md"
  "projects/mango/kb/.gitkeep"
  "projects/mango/prompts/.gitkeep"
  "projects/mango/docs/.gitkeep"
  "projects/mango/experiments/.gitkeep"
  "projects/mango/decisions/.gitkeep"
  "projects/repo-development/README.md"
  "projects/repo-development/docs/migration-audit-2026-05.md"
  "governance/REPO_MODEL.md"
  "governance/ARTIFACT_MAP.md"
  "projects/education-ba-prompt/README.md"
  "projects/education-ba-prompt/docs/course-ideas.md"
  ".github/ISSUE_TEMPLATE/task.yml"
  "tools/validate-frontmatter.sh"
  "tools/validate-repository-structure.sh"
)

for dir in "${required_directories[@]}"; do
  require_dir "$dir"
done

for file in "${required_files[@]}"; do
  require_file "$file"
done

while IFS= read -r file; do
  if is_active_file "$file"; then
    continue
  fi

  if is_old_file "$file"; then
    fail "tracked legacy -old file after migration cleanup: $file"
    continue
  fi

  fail "tracked legacy file without -old suffix: $file"
done < <(git ls-files)

require_text "README.md" "CONCEPT.md"
require_text "README.md" "standards/README.md"
require_text "README.md" "standards/GLOSSARY.md"
require_text "README.md" "standards/TEAM_CONTRACT.md"
require_text "README.md" "governance/REPO_MODEL.md"
require_text "README.md" "governance/ARTIFACT_MAP.md"
require_text "README.md" "projects/education-ba-prompt/README.md"
require_text "README.md" "research/mango/README.md"
require_text "README.md" "./tools/validate-frontmatter.sh"
require_text "README.md" "./tools/validate-repository-structure.sh"

require_text "CONCEPT.md" "governance/REPO_MODEL.md"
require_text "CONCEPT.md" "standards/README.md"
require_text "CONCEPT.md" "Anti-Inflation"
require_text "CONCEPT.md" "status: canonical"
require_text "CONCEPT.md" "version: 1.0"
require_text "CONCEPT.md" "updated: 2026-05-26"
require_text "CONCEPT.md" "ai-generated: false"
require_text "CONCEPT.md" "Версия: 1.0"
require_text "CONCEPT.md" "Operating Mode"
require_text "CONCEPT.md" "structured mode"
require_text "CONCEPT.md" "creative mode"
require_text "CONCEPT.md" "standards/TEAM_CONTRACT.md"
require_text "CONCEPT.md" "Шаблон командного соглашения"
require_text "CONCEPT.md" "GLOSSARY.md"
require_text "CONCEPT.md" "единой терминологии"

require_text "CONTRIBUTING.md" "AI_GOVERNANCE.md"
require_text "CONTRIBUTING.md" "standards/README.md"
require_text "CONTRIBUTING.md" "./tools/validate-frontmatter.sh"
require_text "CONTRIBUTING.md" "./tools/validate-repository-structure.sh"

require_text "AI_GOVERNANCE.md" "Founder & PO"
require_text "AI_GOVERNANCE.md" "Human reviewer"
require_text "AI_GOVERNANCE.md" "standards/README.md"

require_text "CHANGELOG.md" "## Unreleased"
require_text "CHANGELOG.md" "## [1.1] - 2026-05-26"
require_text "CHANGELOG.md" "### Added"
require_text "CHANGELOG.md" "### Changed"
require_text "CHANGELOG.md" "### Removed"

require_text "standards/README.md" "| Стандарт | Статус | Где применяется | Источник |"
require_text "standards/README.md" "Как пользоваться"
require_text "standards/README.md" "FILE_NAMING.md"
require_text "standards/README.md" "RESEARCH_PROFILE.md"
require_text "standards/README.md" "TEAM_CONTRACT.md"
require_text "standards/README.md" "standards/GLOSSARY.md"
require_text "standards/README.md" "standards/EDUCATION_PROFILE.md"
require_text "standards/README.md" "PRODUCT_PROFILE.md"
require_text "standards/README.md" "PROJECT_STRUCTURE_INHERITANCE.md"
require_text "standards/README.md" "ARTIFACT_MAP.md"
require_text "standards/README.md" "ISSUE_WORKFLOW.md"

require_text "standards/TEAM_CONTRACT.md" "status: canonical"
require_text "standards/TEAM_CONTRACT.md" "version: 1.0"
require_text "standards/TEAM_CONTRACT.md" "updated: 2026-05-26"
require_text "standards/TEAM_CONTRACT.md" "ai-generated: false"
require_text "standards/TEAM_CONTRACT.md" "Назначение"
require_text "standards/TEAM_CONTRACT.md" "не является контрактом для прямого использования"
require_text "standards/TEAM_CONTRACT.md" "CONTRIBUTING.md"
require_text "standards/TEAM_CONTRACT.md" "AI_GOVERNANCE.md"
require_text "standards/TEAM_CONTRACT.md" "Definition of Done"
require_text "standards/TEAM_CONTRACT.md" "operating modes"
require_text "standards/TEAM_CONTRACT.md" "disclosure"
require_text "standards/TEAM_CONTRACT.md" "self-review checklist"
require_text "standards/TEAM_CONTRACT.md" "RESEARCH_PROFILE.md"
require_text "standards/TEAM_CONTRACT.md" "PRODUCT_PROFILE.md"
require_text "standards/TEAM_CONTRACT.md" "EDUCATION_PROFILE.md"
require_text "standards/TEAM_CONTRACT.md" "Источники"

require_text "standards/ISSUE_WORKFLOW.md" "status: canonical"
require_text "standards/ISSUE_WORKFLOW.md" "version: 1.0"
require_text "standards/ISSUE_WORKFLOW.md" "updated: 2026-05-26"
require_text "standards/ISSUE_WORKFLOW.md" "ai-generated: false"
require_text "standards/ISSUE_WORKFLOW.md" "## Назначение"
require_text "standards/ISSUE_WORKFLOW.md" "## Статусы задач"
require_text "standards/ISSUE_WORKFLOW.md" "## Правила переходов"
require_text "standards/ISSUE_WORKFLOW.md" "## Связи между артефактами"
require_text "standards/ISSUE_WORKFLOW.md" "## Точки автоматизации"
require_text "standards/ISSUE_WORKFLOW.md" "## Источники и адаптация"
require_text "standards/ISSUE_WORKFLOW.md" '`draft`'
require_text "standards/ISSUE_WORKFLOW.md" '`ready`'
require_text "standards/ISSUE_WORKFLOW.md" '`in-progress`'
require_text "standards/ISSUE_WORKFLOW.md" '`review`'
require_text "standards/ISSUE_WORKFLOW.md" '`merged`'
require_text "standards/ISSUE_WORKFLOW.md" '`closed`'
require_text "standards/ISSUE_WORKFLOW.md" '`blocked`'

require_text "standards/PROJECT_STRUCTURE_INHERITANCE.md" "status: canonical"
require_text "standards/PROJECT_STRUCTURE_INHERITANCE.md" "version: 1.0"
require_text "standards/PROJECT_STRUCTURE_INHERITANCE.md" "updated: 2026-05-26"
require_text "standards/PROJECT_STRUCTURE_INHERITANCE.md" "ai-generated: false"
require_text "standards/PROJECT_STRUCTURE_INHERITANCE.md" "Разрешённые подкаталоги"
require_text "standards/PROJECT_STRUCTURE_INHERITANCE.md" "Правила связывания стандартов"
require_text "standards/PROJECT_STRUCTURE_INHERITANCE.md" "scope: mango-only"
require_text "standards/PROJECT_STRUCTURE_INHERITANCE.md" "Пример структуры проекта"
require_text "standards/PROJECT_STRUCTURE_INHERITANCE.md" "Репозиторий-широкий стандарт НЕ должен ссылаться на проектный"
require_text "standards/ISSUE_WORKFLOW.md" "User Story / ФТ"
require_text "standards/ISSUE_WORKFLOW.md" "CHANGELOG.md"
require_text "standards/ISSUE_WORKFLOW.md" "governance/ARTIFACT_MAP.md"
require_text "standards/ISSUE_WORKFLOW.md" "validate-frontmatter.sh"
require_text "standards/ISSUE_WORKFLOW.md" "validate-repository-structure.sh"
require_text "standards/FILE_NAMING.md" "status: canonical"
require_text "standards/FILE_NAMING.md" "version: 1.0"
require_text "standards/FILE_NAMING.md" "updated: 2026-05-26"
require_text "standards/FILE_NAMING.md" "ai-generated: false"
require_text "standards/FILE_NAMING.md" "Корень репозитория"
require_text "standards/FILE_NAMING.md" "UPPERCASE_WITH_HYPHENS.md"
require_text "standards/FILE_NAMING.md" "Вложенные каталоги"
require_text "standards/FILE_NAMING.md" "lowercase-with-hyphens.md"
require_text "standards/FILE_NAMING.md" "classification-glossary.md"
require_text "standards/FILE_NAMING.md" "Исключения"
require_text "standards/FILE_NAMING.md" "Новый файл не соответствует правилу"

require_text "standards/RESEARCH_PROFILE.md" "status: canonical"
require_text "standards/RESEARCH_PROFILE.md" "version: 1.0"
require_text "standards/RESEARCH_PROFILE.md" "updated: 2026-05-26"
require_text "standards/RESEARCH_PROFILE.md" "ai-generated: false"
require_text "standards/RESEARCH_PROFILE.md" "Назначение"
require_text "standards/RESEARCH_PROFILE.md" "Обязательные артефакты"
require_text "standards/RESEARCH_PROFILE.md" "YYYY-MM-topic.md"
require_text "standards/RESEARCH_PROFILE.md" "exp-<slug>"
require_text "standards/RESEARCH_PROFILE.md" "Шаблон frontmatter исследования"
require_text "standards/RESEARCH_PROFILE.md" "external-analysis | internal-analysis | experiment"
require_text "standards/RESEARCH_PROFILE.md" "Как организовать исследование"
require_text "standards/RESEARCH_PROFILE.md" "Чек-лист готовности к публикации"
require_text "standards/RESEARCH_PROFILE.md" "Правила цитирования источников"
require_text "standards/RESEARCH_PROFILE.md" "FAIR Principles"

require_text "standards/GLOSSARY.md" "status: canonical"
require_text "standards/GLOSSARY.md" "version: 1.0"
require_text "standards/GLOSSARY.md" "updated: 2026-05-26"
require_text "standards/GLOSSARY.md" "ai-generated: false"
require_text "standards/GLOSSARY.md" "Standard"
require_text "standards/GLOSSARY.md" "Concept"
require_text "standards/GLOSSARY.md" "Policy"
require_text "standards/GLOSSARY.md" "Contract"
require_text "standards/GLOSSARY.md" "Practice"
require_text "standards/GLOSSARY.md" "Framework"
require_text "standards/GLOSSARY.md" "Guideline"
require_text "standards/GLOSSARY.md" "Artifact"
require_text "standards/GLOSSARY.md" "Canonical"
require_text "standards/GLOSSARY.md" "Draft"
require_text "standards/GLOSSARY.md" "Operating Mode"
require_text "standards/GLOSSARY.md" "Profile"
require_text "standards/GLOSSARY.md" "Как использовать"
require_text "standards/GLOSSARY.md" "Связи терминов"
require_text "standards/GLOSSARY.md" "Источники"

require_text "standards/EDUCATION_PROFILE.md" "status: canonical"
require_text "standards/EDUCATION_PROFILE.md" "version: 1.0"
require_text "standards/EDUCATION_PROFILE.md" "updated: 2026-05-26"
require_text "standards/EDUCATION_PROFILE.md" "ai-generated: false"
require_text "standards/EDUCATION_PROFILE.md" "## Назначение"
require_text "standards/EDUCATION_PROFILE.md" "PRODUCT_PROFILE.md"
require_text "standards/EDUCATION_PROFILE.md" "RESEARCH_PROFILE.md"
require_text "standards/EDUCATION_PROFILE.md" "| Артефакт | Назначение | Где размещать | Пример/Шаблон |"
require_text "standards/EDUCATION_PROFILE.md" "CONCEPT.md"
require_text "standards/EDUCATION_PROFILE.md" "module-XX/"
require_text "standards/EDUCATION_PROFILE.md" "lesson-01.md"
require_text "standards/EDUCATION_PROFILE.md" "exercise-01.md"
require_text "standards/EDUCATION_PROFILE.md" "solution.md"
require_text "standards/EDUCATION_PROFILE.md" "## Стандарт именования"
require_text "standards/EDUCATION_PROFILE.md" "## Шаблон структуры модуля"
require_text "standards/EDUCATION_PROFILE.md" "## Как адаптировать под формат обучения"
require_text "standards/EDUCATION_PROFILE.md" "Открытый курс"
require_text "standards/EDUCATION_PROFILE.md" "Коммерческий продукт"
require_text "standards/EDUCATION_PROFILE.md" "Внутреннее обучение"
require_text "standards/EDUCATION_PROFILE.md" "## Гибридный формат: чат-бот и LMS"
require_text "standards/EDUCATION_PROFILE.md" "## Источники и адаптация"
require_text "standards/EDUCATION_PROFILE.md" "Carnegie Mellon University Eberly Center"
require_text "standards/EDUCATION_PROFILE.md" "CAST Universal Design for Learning"
require_text "standards/EDUCATION_PROFILE.md" "UNESCO Open Educational Resources"
require_text "standards/EDUCATION_PROFILE.md" "1EdTech Common Cartridge"
require_text "standards/EDUCATION_PROFILE.md" "ADL Experience API"
require_text "standards/PRODUCT_PROFILE.md" "status: canonical"
require_text "standards/PRODUCT_PROFILE.md" "ai-generated: false"
require_text "standards/PRODUCT_PROFILE.md" "PRODUCT_VISION.md"
require_text "standards/PRODUCT_PROFILE.md" "Обязательные артефакты"
require_text "standards/PRODUCT_PROFILE.md" "Метрики успеха"

require_text "governance/REPO_MODEL.md" "Артефакт только при операционной боли"
require_text "governance/REPO_MODEL.md" "Anti-Inflation"
require_text "governance/REPO_MODEL.md" "tools/"

require_text "governance/ARTIFACT_MAP.md" "status: canonical"
require_text "governance/ARTIFACT_MAP.md" "version: 1.1"
require_text "governance/ARTIFACT_MAP.md" "updated: 2026-05-27"
require_text "governance/ARTIFACT_MAP.md" "ai-generated: false"
require_text "governance/ARTIFACT_MAP.md" "| Путь | Тип | Назначение | Обязательный? | Связанные артефакты |"
require_text "governance/ARTIFACT_MAP.md" "Как использовать карту"
require_text "governance/ARTIFACT_MAP.md" "Как обновлять карту"
require_text "governance/ARTIFACT_MAP.md" "GLOSSARY.md"
require_text "governance/ARTIFACT_MAP.md" "research/mango/classification.md"
require_text "governance/ARTIFACT_MAP.md" "research/mango/rag-mapping-roadmap-2026-05.md"
require_text "governance/ARTIFACT_MAP.md" "projects/mango/standards/classification-glossary.md"
require_text "governance/ARTIFACT_MAP.md" "projects/README.md"

require_text "research/README.md" "status: canonical"
require_text "research/README.md" "standards/RESEARCH_PROFILE.md"
require_text "research/README.md" "research/<domain>/exp-<slug>/"

require_text "research/mango/README.md" "status: canonical"
require_text "research/mango/README.md" "classification.md"
require_text "research/mango/README.md" "requirements-flow.md"
require_text "research/mango/README.md" "rag-mapping-roadmap-2026-05.md"
require_text "research/mango/README.md" "research/mango/exp-tz-corpus/"

require_text "research/mango/classification.md" "status: reviewed"
require_text "research/mango/classification.md" "source: research/mango/classification-old.md"
require_text "research/mango/classification-tz.md" "status: reviewed"
require_text "research/mango/classification-tz.md" "source: research/mango/classification-tz-old.md"
require_text "research/mango/requirements-flow.md" "status: reviewed"
require_text "research/mango/requirements-flow.md" "source: research/mango/requirements-flow-old.md"
require_text "research/mango/rag-mapping-roadmap-2026-05.md" "status: draft"
require_text "research/mango/rag-mapping-roadmap-2026-05.md" "type: process-research"
require_text "research/mango/rag-mapping-roadmap-2026-05.md" "Маппинг продуктов/фич"
require_text "research/mango/rag-mapping-roadmap-2026-05.md" "Roadmap реализации проекта"
require_text "research/mango/rag-mapping-roadmap-2026-05.md" "PlantUML"
require_text "research/mango/rag-mapping-roadmap-2026-05.md" "Вопросы для согласования"

require_text "research/mango/capability-decomposition-2026-05.md" "status: draft"
require_text "research/mango/capability-decomposition-2026-05.md" "type: atomic-functions-reference"
require_text "research/mango/capability-decomposition-2026-05.md" "scope: mango-only"
require_text "research/mango/capability-decomposition-2026-05.md" "Критерии атомарности"
require_text "research/mango/capability-decomposition-2026-05.md" "Связь с НФТ-классами"
require_text "research/mango/capability-decomposition-2026-05.md" "Интеграция с"
require_text "research/mango/capability-decomposition-2026-05.md" "Как обновлять справочник"
require_text "research/mango/capability-decomposition-2026-05.md" "Вопросы для согласования с PO/Founder"
require_text "research/mango/capability-decomposition-2026-05.md" "Domain: voice-ucaas"
require_text "research/mango/capability-decomposition-2026-05.md" "Domain: contact-center"
require_text "research/mango/capability-decomposition-2026-05.md" "Domain: digital-channels"

require_text "projects/README.md" "status: canonical"
require_text "projects/README.md" "mango/"
require_text "projects/README.md" "repo-development/"

require_text "projects/mango/README.md" "research/mango/README.md"
require_text "projects/mango/README.md" "standards/classification-glossary.md"
require_text "projects/mango/README.md" 'Все исследования Mango используют термины из `standards/classification-glossary.md`'

require_text "projects/mango/standards/classification-glossary.md" "status: draft"
require_text "projects/mango/standards/classification-glossary.md" "version: 0.1"
require_text "projects/mango/standards/classification-glossary.md" "updated: 2026-05-26"
require_text "projects/mango/standards/classification-glossary.md" "ai-generated: false"
require_text "projects/mango/standards/classification-glossary.md" "scope: mango-only"
require_text "projects/mango/standards/classification-glossary.md" "Domain (Семейство)"
require_text "projects/mango/standards/classification-glossary.md" "Capability (Класс)"
require_text "projects/mango/standards/classification-glossary.md" "Feature (Подкласс)"
require_text "projects/mango/standards/classification-glossary.md" "Atomic Function (Функция)"
require_text "projects/mango/standards/classification-glossary.md" "Термин Mango | Международный аналог | Источник | Пример использования"
require_text "projects/mango/standards/classification-glossary.md" "⚠️ Требуется уточнение"

require_text "education/README.md" "status: canonical"
require_text "education/README.md" "standards/EDUCATION_PROFILE.md"

require_text "frameworks/README.md" "status: canonical"
require_text "frameworks/README.md" "governance/REPO_MODEL.md"

require_text "projects/education-ba-prompt/README.md" "status: draft"
require_text "projects/education-ba-prompt/README.md" "version: 0.1"
require_text "projects/education-ba-prompt/README.md" "updated: 2026-05-26"
require_text "projects/education-ba-prompt/README.md" "ai-generated: false"
require_text "projects/education-ba-prompt/README.md" "docs/course-ideas.md"
require_text "projects/education-ba-prompt/README.md" "standards/EDUCATION_PROFILE.md"

require_text "projects/education-ba-prompt/docs/course-ideas.md" "status: draft"
require_text "projects/education-ba-prompt/docs/course-ideas.md" "version: 0.1"
require_text "projects/education-ba-prompt/docs/course-ideas.md" "updated: 2026-05-26"
require_text "projects/education-ba-prompt/docs/course-ideas.md" "ai-generated: false"
require_text "projects/education-ba-prompt/docs/course-ideas.md" "## 🔹 Термины и концепции"
require_text "projects/education-ba-prompt/docs/course-ideas.md" "## 🔹 Практические кейсы БА"
require_text "projects/education-ba-prompt/docs/course-ideas.md" "## 🔹 Шаблоны промптов (рабочие)"
require_text "projects/education-ba-prompt/docs/course-ideas.md" "## 🔹 Идеи модулей курса"
require_text "projects/education-ba-prompt/docs/course-ideas.md" "## 🔹 Форматы подачи"
require_text "projects/education-ba-prompt/docs/course-ideas.md" "## 🔹 Вопросы для обсуждения"

require_text ".github/ISSUE_TEMPLATE/task.yml" "📋 Task Implementation"
require_text ".github/ISSUE_TEMPLATE/task.yml" "structured"
require_text ".github/ISSUE_TEMPLATE/task.yml" "creative"
require_text ".github/ISSUE_TEMPLATE/task.yml" "⚠️ **Для ИИ**"
require_text ".github/ISSUE_TEMPLATE/task.yml" "🎯 Контекст"
require_text ".github/ISSUE_TEMPLATE/task.yml" "📄 Артефакты для создания/изменения"
require_text ".github/ISSUE_TEMPLATE/task.yml" "✅ Готово, когда"

if [[ -e meta/README.md ]]; then
  fail "active meta/README.md should move to governance/"
fi

if [[ -e tests/validate-repository-structure.sh ]]; then
  fail "active tests/validate-repository-structure.sh should move to tools/"
fi

if [[ "$failures" -gt 0 ]]; then
  printf '\nRepository structure validation failed with %d issue(s).\n' "$failures" >&2
  exit 1
fi

printf 'Repository structure validation passed.\n'
