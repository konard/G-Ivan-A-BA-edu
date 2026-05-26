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
    standards/RESEARCH_PROFILE.md | \
    standards/GLOSSARY.md | \
    standards/EDUCATION_PROFILE.md | \
    standards/PRODUCT_PROFILE.md | \
    standards/TEAM_CONTRACT.md | \
    standards/ISSUE_WORKFLOW.md | \
    governance/REPO_MODEL.md | \
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
  "standards/RESEARCH_PROFILE.md"
  "standards/GLOSSARY.md"
  "standards/EDUCATION_PROFILE.md"
  "standards/PRODUCT_PROFILE.md"
  "standards/TEAM_CONTRACT.md"
  "standards/ISSUE_WORKFLOW.md"
  "governance/REPO_MODEL.md"
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

old_file_count=0
while IFS= read -r file; do
  if is_active_file "$file"; then
    continue
  fi

  if is_old_file "$file"; then
    old_file_count=$((old_file_count + 1))
    continue
  fi

  fail "tracked legacy file without -old suffix: $file"
done < <(git ls-files)

if [[ "$old_file_count" -eq 0 ]]; then
  fail "expected preserved -old files for migration analysis"
fi

require_text "README.md" "CONCEPT.md"
require_text "README.md" "standards/README.md"
require_text "README.md" "standards/GLOSSARY.md"
require_text "README.md" "standards/TEAM_CONTRACT.md"
require_text "README.md" "governance/REPO_MODEL.md"
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
require_text "CHANGELOG.md" "### Added"
require_text "CHANGELOG.md" "### Changed"
require_text "CHANGELOG.md" "### Removed"

require_text "standards/README.md" "| Стандарт | Статус | Где применяется | Источник |"
require_text "standards/README.md" "Как пользоваться"
require_text "standards/README.md" "RESEARCH_PROFILE.md"
require_text "standards/README.md" "TEAM_CONTRACT.md"
require_text "standards/README.md" "standards/GLOSSARY.md"
require_text "standards/README.md" "standards/EDUCATION_PROFILE.md"
require_text "standards/README.md" "PRODUCT_PROFILE.md"
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
require_text "standards/ISSUE_WORKFLOW.md" "User Story / ФТ"
require_text "standards/ISSUE_WORKFLOW.md" "CHANGELOG.md"
require_text "standards/ISSUE_WORKFLOW.md" "governance/ARTIFACT_MAP.md"
require_text "standards/ISSUE_WORKFLOW.md" "validate-frontmatter.sh"
require_text "standards/ISSUE_WORKFLOW.md" "validate-repository-structure.sh"

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

require_text ".github/ISSUE_TEMPLATE/task.yml" "📋 Task Implementation"
require_text ".github/ISSUE_TEMPLATE/task.yml" "structured"
require_text ".github/ISSUE_TEMPLATE/task.yml" "creative"
require_text ".github/ISSUE_TEMPLATE/task.yml" "⚠️ **Для ИИ**"
require_text ".github/ISSUE_TEMPLATE/task.yml" "🎯 Контекст"
require_text ".github/ISSUE_TEMPLATE/task.yml" "📄 Артефакты для создания/изменения"
require_text ".github/ISSUE_TEMPLATE/task.yml" "✅ Готово, когда"

if [[ -e meta/README.md ]]; then
  fail "active meta/README.md should be renamed to meta/README-old.md"
fi

if [[ -e tests/validate-repository-structure.sh ]]; then
  fail "active tests/validate-repository-structure.sh should move to tools/"
fi

if [[ "$failures" -gt 0 ]]; then
  printf '\nRepository structure validation failed with %d issue(s).\n' "$failures" >&2
  exit 1
fi

printf 'Repository structure validation passed.\n'
