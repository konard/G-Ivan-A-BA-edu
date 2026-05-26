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

reject_path() {
  local path="$1"
  [[ ! -e "$path" ]] || fail "legacy path should not exist: $path"
}

required_directories=(
  ".github"
  ".github/ISSUE_TEMPLATE"
  "docs/concept"
  "docs/governance"
  "education"
  "education/ba-prompt-engineering"
  "experiments"
  "experiments/mango"
  "experiments/mango/tz-corpus"
  "frameworks"
  "meta"
  "projects"
  "research"
  "research/mango"
  "research/repository-governance"
  "standards"
  "tests"
)

required_files=(
  ".github/ISSUE_TEMPLATE/ai_implementation_task.yml"
  ".github/ISSUE_TEMPLATE/config.yml"
  ".github/ISSUE_TEMPLATE/governance_change.md"
  ".github/ISSUE_TEMPLATE/research_task.md"
  ".github/pull_request_template.md"
  "AI_GOVERNANCE.md"
  "CHANGELOG.md"
  "CONTRIBUTING.md"
  "LICENSE"
  "PRODUCT_VISION.md"
  "README.md"
  "docs/concept/repository-structure.md"
  "docs/concept/vision-standard.md"
  "docs/governance/hybrid-team-collaboration.md"
  "education/README.md"
  "education/ba-prompt-engineering/DELIVERABLES.md"
  "education/ba-prompt-engineering/course-structure.md"
  "education/ba-prompt-engineering/presentation-content.md"
  "education/ba-prompt-engineering/presentation-structure.md"
  "education/ba-prompt-engineering/teacher-scenario.md"
  "experiments/mango/tz-corpus/README.md"
  "experiments/mango/tz-corpus/.gitignore"
  "experiments/mango/tz-corpus/build_html.py"
  "experiments/mango/tz-corpus/extract_docx.py"
  "experiments/mango/tz-corpus/urls.txt"
  "frameworks/README.md"
  "meta/README.md"
  "projects/README.md"
  "research/README.md"
  "research/mango/README.md"
  "research/mango/classification.md"
  "research/mango/classification-tz.md"
  "research/mango/requirements-flow.md"
  "research/repository-governance/README.md"
  "research/repository-governance/comparison.md"
  "research/repository-governance/final-vision.md"
  "research/repository-governance/change-proposal.md"
  "standards/README.md"
)

legacy_root_paths=(
  ".gitkeep"
  "DELIVERABLES.md"
  "course-structure.md"
  "presentation-content.md"
  "presentation-structure.md"
  "teacher-scenario.md"
  "experiments/tz-corpus"
)

core_identity_files=(
  "README.md"
  "PRODUCT_VISION.md"
  "AI_GOVERNANCE.md"
  "docs/concept/repository-structure.md"
  "docs/concept/vision-standard.md"
)

experiment_reference_files=(
  "README.md"
  "docs/concept/repository-structure.md"
  "experiments/mango/tz-corpus/README.md"
  "research/mango/README.md"
  "research/mango/classification-tz.md"
  "research/mango/classification-tz.html"
)

for dir in "${required_directories[@]}"; do
  require_dir "$dir"
done

for file in "${required_files[@]}"; do
  require_file "$file"
done

for path in "${legacy_root_paths[@]}"; do
  reject_path "$path"
done

for file in "${core_identity_files[@]}"; do
  if [[ -f "$file" ]] && grep -q "research-and-edu-ai-lab" "$file"; then
    fail "$file must use hybrid-Intelligence-lab, not research-and-edu-ai-lab"
  fi
done

for file in "${experiment_reference_files[@]}"; do
  if [[ -f "$file" ]] && grep -q "experiments/tz-corpus" "$file"; then
    fail "$file must reference experiments/mango/tz-corpus"
  fi
done

if [[ -f README.md ]]; then
  grep -q "PRODUCT_VISION.md" README.md || fail "README.md must link PRODUCT_VISION.md"
  grep -q "AI_GOVERNANCE.md" README.md || fail "README.md must link AI_GOVERNANCE.md"
  grep -q "CHANGELOG.md" README.md || fail "README.md must link CHANGELOG.md"
  grep -q "CONTRIBUTING.md" README.md || fail "README.md must link CONTRIBUTING.md"
fi

if [[ -f AI_GOVERNANCE.md ]]; then
  grep -q "Founder & PO" AI_GOVERNANCE.md || fail "AI_GOVERNANCE.md must define Founder & PO role"
  grep -q "Команда C" AI_GOVERNANCE.md || fail "AI_GOVERNANCE.md must define support team role"
fi

if [[ -f docs/concept/repository-structure.md ]]; then
  grep -q "ru/en" docs/concept/repository-structure.md || fail "repository structure must define bilingual ru/en policy"
  grep -q "Hub-and-Spoke" docs/concept/repository-structure.md || fail "repository structure must document Hub-and-Spoke option"
fi

if [[ -f CHANGELOG.md ]]; then
  grep -q "## Unreleased" CHANGELOG.md || fail "CHANGELOG.md must contain ## Unreleased"
  grep -q "### Added" CHANGELOG.md || fail "CHANGELOG.md must contain ### Added"
  grep -q "### Changed" CHANGELOG.md || fail "CHANGELOG.md must contain ### Changed"
  grep -q "### Removed" CHANGELOG.md || fail "CHANGELOG.md must contain ### Removed"
  grep -q "## TODO" CHANGELOG.md || fail "CHANGELOG.md must contain ## TODO"
fi

if [[ -f CONTRIBUTING.md ]]; then
  grep -q "AI_GOVERNANCE.md" CONTRIBUTING.md || fail "CONTRIBUTING.md must link AI_GOVERNANCE.md"
  grep -q "docs/governance/hybrid-team-collaboration.md" CONTRIBUTING.md || fail "CONTRIBUTING.md must link hybrid-team-collaboration.md"
  grep -q "docs/concept/repository-structure.md" CONTRIBUTING.md || fail "CONTRIBUTING.md must link repository-structure.md"
  grep -q "tests/validate-repository-structure.sh" CONTRIBUTING.md || fail "CONTRIBUTING.md must mention structure validation"
fi

if [[ "$failures" -gt 0 ]]; then
  printf '\nRepository structure validation failed with %d issue(s).\n' "$failures" >&2
  exit 1
fi

printf 'Repository structure validation passed.\n'
