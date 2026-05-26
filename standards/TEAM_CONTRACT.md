---
status: canonical
version: 1.0
updated: 2026-05-26
ai-generated: false
---

# Team Contract

Версия: 1.0

Дата: 2026-05-26

## Назначение

`TEAM_CONTRACT.md` - это шаблон, набор лучших практик и инструкция по
адаптации для проектных репозиториев, которые используют подходы
`hybrid-Intelligence-lab`.

Этот документ не является контрактом для прямого использования, юридическим
соглашением или активным правилом конкретной команды. Его нужно адаптировать
под контекст проекта и на его основе создать два проектных файла:

| Файл в проекте | Что фиксирует |
| --- | --- |
| `CONTRIBUTING.md` | Роли, процесс внесения изменений, code review, Definition of Done и ожидания к PR. |
| `AI_GOVERNANCE.md` | Правила работы ИИ, operating modes, disclosure, self-review checklist, data boundaries и escalation rules. |

Хороший team contract отвечает на практический вопрос: как human contributors,
reviewers и AI agents безопасно и предсказуемо двигают проект от issue до
reviewed result.

## Что должно получиться в проекте

Минимальный результат адаптации:

1. Выбран профиль проекта:
   [RESEARCH_PROFILE.md](#research_profilemd),
   [PRODUCT_PROFILE.md](#product_profilemd) или
   [EDUCATION_PROFILE.md](#education_profilemd).
2. Создан `CONTRIBUTING.md`, который объясняет человеческий workflow.
3. Создан `AI_GOVERNANCE.md`, который объясняет AI-assisted workflow.
4. PR template или issue template ссылается на оба файла, если проект
   принимает внешние или cross-team contributions.
5. Branch protection, required checks, CODEOWNERS и security policy включены
   только там, где они реально поддерживаются командой.

## Выбор профиля проекта

Профиль нужен до написания `CONTRIBUTING.md` и `AI_GOVERNANCE.md`: он задает
контекст, в котором команда выбирает обязательные проверки, review roles и
уровень строгости.

| Профиль | Когда выбирать | Главный риск | Что усиливать в контракте |
| --- | --- | --- | --- |
| [RESEARCH_PROFILE.md](#research_profilemd) | Исследования, reports, experiments, datasets, methods. | Непроверяемые claims, слабая воспроизводимость, sensitive data. | Sources, method, limitations, reproducibility, publication boundary. |
| [PRODUCT_PROFILE.md](#product_profilemd) | Production code, product delivery, integrations, releases. | Regression, security, broken ownership, unreviewed AI output. | CI, code review, CODEOWNERS, release gates, rollback, secrets policy. |
| [EDUCATION_PROFILE.md](#education_profilemd) | Courses, lessons, scenarios, open education materials. | Несовпадение с аудиторией, устаревшие материалы, неясные learning outcomes. | Audience, learning goals, review by teacher/domain expert, update cadence. |

### RESEARCH_PROFILE.md

Создайте этот профиль в проекте, если основной результат - исследование,
аналитический отчет, corpus, experiment или methodology.

Минимальные поля:

- research question;
- method and source selection criteria;
- data sensitivity and publication boundary;
- reproducibility artifacts: commands, notebooks, datasets or limitations;
- reviewer roles: domain reviewer, source reviewer, ethics or privacy reviewer
  when needed;
- rule for AI-assisted summaries: sources must be linked and unverifiable
  claims must be marked as assumptions.

### PRODUCT_PROFILE.md

Создайте этот профиль в проекте, если репозиторий содержит production code,
product implementation, deployment, integrations or user-facing workflows.

Минимальные поля:

- product owner and technical owner;
- supported environments and release cadence;
- required checks: unit tests, integration tests, linters, security scans or
  manual QA;
- ownership map for critical paths;
- secrets, credentials and customer data boundaries;
- rollback or incident escalation path;
- AI usage boundary: allowed coding assistance, forbidden autonomous changes,
  required human review for generated code.

### EDUCATION_PROFILE.md

Создайте этот профиль в проекте, если основной результат - course, lesson plan,
training scenario, rubric or public learning material.

Минимальные поля:

- target audience and prerequisites;
- learning outcomes;
- delivery format: self-study, workshop, teacher-led, blended;
- content owner and pedagogical reviewer;
- accessibility and localization expectations;
- update cadence and archival rule for outdated material;
- AI usage boundary for generated examples, translations and exercises.

## Как адаптировать под проект

Перед созданием project-level files ответьте на вопросы:

1. Какой тип результата важнее всего: research, product, education или
   смешанный проект?
2. Кто принимает финальное решение: Founder & PO, maintainer, product owner,
   research lead, teacher or designated reviewer?
3. Какие изменения требуют issue до PR?
4. Какие файлы или домены требуют обязательного reviewer или CODEOWNERS?
5. Какие проверки реально запускаются локально и в CI?
6. Какие данные нельзя публиковать: secrets, credentials, client data, private
   prompts, unpublished research data, student data?
7. Где AI может помогать, а где требуется explicit human approval?
8. Что должно быть раскрыто в PR: AI assistance, sources, assumptions,
   generated assets, unverified claims?
9. Как команда отклоняет out-of-scope PR так, чтобы сохранить ясность и не
   плодить повторяющиеся обсуждения?
10. Когда нужен follow-up issue вместо расширения текущего PR?

### Матрица обязательных и опциональных элементов

| Элемент | Minimum | Standard | High-risk / regulated |
| --- | --- | --- | --- |
| Project profile | Обязателен короткий профиль. | Отдельный `*_PROFILE.md`. | Отдельный профиль с risk register. |
| Roles | Owner, reviewer, contributor, AI agent. | Добавить domain owners. | Добавить approvers for security, legal, privacy or ethics. |
| Change process | Issue, branch, PR, review, merge. | Добавить PR template and release notes. | Добавить change approval, audit trail and rollback plan. |
| Code review | Минимум один human reviewer для meaningful changes. | Required review for protected branches. | Code owner review and stale review dismissal. |
| Definition of Done | Scope, checks, docs, risks. | Добавить examples and non-goals. | Добавить evidence, sign-off and monitoring. |
| AI rules | Boundaries, disclosure, self-review. | Operating modes and escalation rules. | Risk assessment, logs, evals and human approval gates. |
| Sources | Required for claims that affect decisions. | Source quality criteria. | Source archive, version/date and limitations. |
| Security | Secrets must not be committed. | Security policy and dependency update rule. | Threat model, SAST, SBOM or formal security review. |
| Templates | Optional. | Issue and PR templates. | Mandatory forms with explicit risk fields. |

### Три рабочих размера контракта

| Размер | Плюсы | Минусы | Когда применять |
| --- | --- | --- | --- |
| Minimum | Быстро внедряется, подходит маленькой команде. | Может не хватить для сложных releases or external contributors. | Early research, private prototypes, small education repo. |
| Standard | Балансирует ясность, reviewability and automation. | Требует дисциплины в issue and PR templates. | Большинство spoke-проектов. |
| High-risk | Лучше покрывает security, privacy, compliance and audit needs. | Легко превратить в enterprise-overkill. | Customer data, production AI systems, regulated or public launch projects. |

## Шаблон для CONTRIBUTING.md

`CONTRIBUTING.md` должен быть коротким рабочим контрактом. Его цель - снизить
стоимость review и помочь contributor заранее понять, что будет принято.

Рекомендуемая структура:

```markdown
# Contributing

## Назначение

Что за проект, какие contributions принимаются, какие изменения out of scope.

## Роли

| Роль | Ответственность |
| --- | --- |
| Owner / PO | Приоритеты, scope, финальные product или publication decisions. |
| Maintainer | Branch policy, merge decisions, release readiness. |
| Reviewer | Проверка correctness, risk, maintainability, sources and tests. |
| Contributor | Issue, focused PR, checks, response to review. |
| AI agent | Drafts, code, tests, summaries внутри scope и по AI_GOVERNANCE.md. |

## Процесс внесения изменений

1. Начать с issue или maintainer request.
2. Согласовать scope, acceptance criteria and non-goals.
3. Создать branch от default branch.
4. Сделать focused commits.
5. Запустить локальные проверки.
6. Открыть PR с summary, tests, risks and review focus.
7. Обработать review comments без unrelated refactoring.
8. Merge после required approvals and checks.

## Code Review

- Meaningful changes require human review.
- Critical paths use CODEOWNERS or named reviewers.
- Review проверяет behavior, tests, data boundaries, documentation and
  maintainability.
- New commits after approval may require re-review when they change the diff.
- Out-of-scope changes move to follow-up issue.

## Definition of Done

- Linked issue or explicit maintainer request.
- Acceptance criteria covered.
- Tests or validation run and documented.
- Documentation updated when behavior or workflow changed.
- AI assistance disclosed when used.
- Risks, assumptions and follow-ups visible in PR.
```

### Примечания к адаптации CONTRIBUTING.md

- Не добавляйте role, если у нее нет реального owner.
- Не требуйте CI check, который команда не поддерживает.
- Если проект принимает external contributors, добавьте issue and PR templates.
- Если есть sensitive data or production access, добавьте security section and
  escalation path.
- Если проект маленький, держите contract на 1-2 страницы.

## Шаблон для AI_GOVERNANCE.md

`AI_GOVERNANCE.md` должен объяснять, как AI может помогать команде без потери
human decision rights, traceability and safety.

Рекомендуемая структура:

```markdown
# AI Governance

## Назначение

Как AI-assisted work используется в проекте, какие границы заданы и кто
принимает финальные решения.

## Роли

| Роль | Ответственность |
| --- | --- |
| Human owner | Scope, priorities, publication, release and risk decisions. |
| Human reviewer | Проверяет correctness, sources, tests, safety and project fit. |
| Contributor | Использует AI только в пределах project rules. |
| AI agent | Готовит drafts, code, tests, summaries and checks; не принимает финальные решения. |

## Правила работы ИИ

1. Work starts from issue, task, ticket or explicit maintainer request.
2. AI reads relevant context before changing files.
3. AI does not commit secrets, private client data, credentials or unsanitized
   prompts.
4. AI-generated code, docs or assets require human review before merge or
   publication.
5. Claims that affect decisions must link to sources, experiments, logs or
   repository artifacts.
6. AI must mark assumptions and limitations instead of presenting guesses as
   facts.
7. Destructive operations, public releases and sensitive data handling require
   explicit human approval.

## Operating Modes

| Mode | Когда использовать | Ожидаемое поведение |
| --- | --- | --- |
| Structured | Default for implementation, docs, governance and maintenance. | Follow scope, use existing patterns, run checks, keep PR reviewable. |
| Research | Source-backed analysis, comparisons, standards and market/domain research. | State method, cite sources, separate evidence from assumptions. |
| Creative | Ideation, concept options, learning scenarios or early design variants. | Produce options with pros/cons; do not turn proposals into policy without review. |
| Incident | Bug, outage, security issue or data leak. | Preserve evidence, minimize blast radius, escalate quickly. |

## Disclosure

PRs and published artifacts should disclose:

- whether AI assistance was used;
- what AI changed or generated;
- sources, experiments or logs used for important claims;
- assumptions that still need human review;
- generated assets or external materials requiring license or attribution check.

## Self-review checklist

- Scope matches the issue or request.
- Relevant files, comments and previous decisions were read.
- Tests, validation or manual checks are listed.
- No secrets, credentials or sensitive data are included.
- AI-generated code was reviewed by a human before merge.
- Sources are linked for factual claims.
- Risks, assumptions and follow-ups are visible.
- The reviewer knows where to focus attention.

## Escalation

Pause and ask for human guidance when requirements conflict, sensitive data may
be exposed, a release decision is needed, sources cannot verify an important
claim, or the AI would need to operate outside the approved scope.
```

### Примечания к адаптации AI_GOVERNANCE.md

- Для research-проекта усиливайте sources, method, limitations and
  reproducibility.
- Для product-проекта усиливайте tests, security review, rollback and
  data-boundary rules.
- Для education-проекта усиливайте audience fit, review by teacher and update
  cadence.
- Для high-risk AI systems добавляйте risk register, evals, monitoring and
  explicit approval gates.

## Примеры адаптации

### Research project

- `RESEARCH_PROFILE.md`: research question, dataset policy, reproducibility.
- `CONTRIBUTING.md`: issue-first changes, source-backed reports, experiment
  folders, review by domain expert.
- `AI_GOVERNANCE.md`: AI can summarize sources and draft analysis, but must
  link sources and mark unverifiable claims.
- Definition of Done: method described, sources linked, limitations stated,
  reproducibility artifacts included or limitations explained.

### Product repository

- `PRODUCT_PROFILE.md`: owners, environments, release cadence, support
  boundaries.
- `CONTRIBUTING.md`: branch from `main`, PR template, required checks,
  CODEOWNERS for critical paths.
- `AI_GOVERNANCE.md`: AI may draft code and tests; secrets, customer data,
  release actions and destructive operations require human approval.
- Definition of Done: tests pass, docs updated, security-sensitive paths
  reviewed, rollback risk understood.

### Education repository

- `EDUCATION_PROFILE.md`: audience, learning outcomes, delivery format,
  accessibility and localization.
- `CONTRIBUTING.md`: lesson changes require learning objective and teacher
  review; examples must be runnable or clearly marked as conceptual.
- `AI_GOVERNANCE.md`: AI may draft exercises and translations; human reviewer
  checks correctness, tone, bias and audience fit.
- Definition of Done: lesson outcome clear, examples validated, outdated
  references removed or dated.

## Практики, интегрированные в шаблон

| Паттерн | Как применять без overkill |
| --- | --- |
| Contributor guidelines | Держать `CONTRIBUTING.md` в корне, `docs/` или `.github/`, чтобы contributors видели правила до issue or PR. |
| Issue and PR templates | Использовать для repeatable context: linked issue, scope, checks, risks, AI disclosure. |
| Protected branches | Включать required reviews and required checks для default branch, если команда реально поддерживает review and CI. |
| CODEOWNERS | Назначать path owners только для областей, где есть активные owners and review capacity. |
| Maintainer best practices | Явно описывать, какие contributions принимаются, и переносить повторяющиеся отказы в документацию. |
| OpenSSF-style project health | Проверять code review, CI tests, branch protection, maintained dependencies and security policy там, где есть codebase. |
| NIST AI RMF | Использовать lightweight цикл: govern roles and policies, map AI risks, measure checks/evals, manage mitigations and escalation. |
| OWASP GenAI security | Для LLM-enabled projects явно фиксировать risks around prompt injection, data leakage, insecure output handling and supply chain. |

## Источники

- GitHub Docs: Setting guidelines for repository contributors -
  https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/setting-guidelines-for-repository-contributors
- GitHub Docs: About protected branches -
  https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches
- GitHub Docs: About code owners -
  https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners
- GitHub Docs: Creating a pull request template -
  https://docs.github.com/articles/creating-a-pull-request-template-for-your-repository
- Open Source Guides: Best Practices for Maintainers -
  https://opensource.guide/best-practices/
- OpenSSF Scorecard -
  https://github.com/ossf/scorecard
- NIST AI Risk Management Framework -
  https://www.nist.gov/itl/ai-risk-management-framework
- NIST AI RMF Generative AI Profile -
  https://doi.org/10.6028/NIST.AI.600-1
- OWASP Top 10 for Large Language Model Applications -
  https://owasp.org/www-project-top-10-for-large-language-model-applications/
- OWASP LLM Applications Cybersecurity and Governance Checklist -
  https://genai.owasp.org/resource/llm-applications-cybersecurity-and-governance-checklist-english/

## Anti-overkill правило

Если правило нельзя проверить, назначить owner или применить в ближайших PR, не
делайте его обязательным. Запишите его как optional practice или follow-up
issue. Team contract должен помогать команде быстрее принимать хорошие решения,
а не создавать символическую бюрократию.
