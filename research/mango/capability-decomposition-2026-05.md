---
status: draft
version: 0.1
updated: 2026-05-27
ai-generated: false
type: atomic-functions-reference
context: [voice-ucaas, contact-center, digital-channels]
method: international-benchmark + atomic-decomposition + practical-mapping
scope: mango-only
related_artifacts:
  - "classification.md v3.0"
  - "classification-glossary.md"
  - "classification-tz.md"
---

# Справочник атомарных функций пилотных доменов Mango

Версия: 0.1

Дата: 2026-05-27

Справочник детализирует уровень `Atomic Function` для трёх пилотных доменов
Mango — `voice-ucaas`, `contact-center`, `digital-channels`. Он отвечает на
вопрос «из каких минимальных проверяемых функций состоит capability и какими
параметрами они настраиваются», чтобы бизнес-аналитик и системный промпт могли:

- точно маппить входящее требование на конкретную функцию («хочу статистику по
  обзвону» → `realtime-reporting` или `disposition-code-assignment`?);
- генерировать ФТ с известными параметрами, а не выдумывать их;
- проводить Gap-анализ на уровне функции, а не только продукта;
- обеспечивать **Output Stability** и **Consistency** генерации за счёт
  согласованного словаря функций и параметров.

## Связь с другими документами и граница ответственности

Этот файл **дополняет**, а не повторяет другие артефакты Mango:

| Документ | Что отвечает | Чем отличается от этого справочника |
| --- | --- | --- |
| [classification.md](classification.md) v3.0, §`📊 Product Layer` | Какие `Domain → Capability → Feature → Atomic Function` существуют и каков их `Mango status`. | Перечисляет функции списком с краткими параметрами; здесь — полная детализация (типы, диапазоны, источники, примеры, НФТ). |
| [projects/mango/standards/classification-glossary.md](../../projects/mango/standards/classification-glossary.md) | Что означают уровни иерархии и термины. | Термины берём из глоссария, не переопределяем. |
| [classification-tz.md](classification-tz.md) | Какой реальный спрос виден в корпусе из 30 ТЗ (классы A/B/C). | Здесь — источник примеров требований (`example_requirements`) и НФТ-классов (`related_nfr`). |
| [rag-mapping-roadmap-2026-05.md](rag-mapping-roadmap-2026-05.md) | Как `kb/product-matrix.md` навигирует промпт к документации. | Здесь — формат запроса «требование → функция» и связь со схемой записи `product-matrix`. |

> Идентификаторы доменов, capability, features и функций намеренно совпадают с
> §`📊 Product Layer` файла `classification.md` v3.0. Если функция уже описана
> там, этот справочник добавляет детализацию, не меняя её идентификатор. Новые
> функции, отсутствующие в `classification.md`, помечены `(новая)`.

## Как пользоваться справочником

1. Нормализуйте входящее требование до уровня функции (см. §«🧩 Интеграция с
   `kb/product-matrix.md`»).
2. Найдите домен и capability, затем feature и атомарную функцию.
3. Возьмите из YAML-записи функции параметры, источники и связанные НФТ.
4. Если требование не маппится ни на одну функцию — это сигнал gap или
   кандидат на новую функцию (см. §«🔄 Как обновлять справочник»).

### Формат записи атомарной функции

Каждая `Feature` представлена YAML-блоком — человекочитаемым и пригодным для
парсинга промптом. Поля записи:

```yaml
domain: "<lowercase-with-hyphens>"          # домен из classification.md
capability: "<lowercase-with-hyphens>"      # capability из classification.md
feature: "<lowercase-with-hyphens>"         # настраиваемая возможность
atomic_functions:
  - id: "<lowercase-with-hyphens>"          # стабильный ID функции
    name: "<человекочитаемое имя>"
    description: "<одна проверяемая бизнес-ценность>"
    parameters:
      - name: "<snake_case>"                # имя параметра
        type: "<enum|int|float|percent|duration|string|list|bool>"
        range: "<диапазон или допустимые значения>"
        origin: "<standard|mango-custom>"   # см. §«Соглашения по параметрам»
        description: "<назначение параметра>"
    international_sources: ["<источник 1>", "<источник 2>"]   # >= 2
    example_requirements: ["<цитата/перефраз из ТЗ> (TZ N)"]  # >= 1
    related_nfr: ["<класс НФТ из classification-tz.md>"]      # опционально
```

> ⚠️ **О диапазонах параметров.** Диапазоны и значения по умолчанию приведены
> как рабочие ориентиры на основе международной практики (vendor docs, стандарты)
> и подлежат подтверждению product SME до фиксации в ФТ. Это исследовательский
> draft, а не продуктовая спецификация (см. `status: draft`).

## 🔍 Критерии атомарности

Функция считается атомарной, если **выполняются все** критерии чек-листа.
Если хотя бы один нарушен — это, скорее всего, `Feature` (составная) или,
наоборот, технический параметр другой функции.

| # | Критерий | Контрольный вопрос | Пример «да» | Пример «нет» |
| --- | --- | --- | --- | --- |
| C1 | **Независимая тестируемость** | Можно ли написать отдельный acceptance criterion и проверить функцию изолированно? | `answering-machine-detection` тестируется отдельным тест-кейсом (АОН/автоответчик → действие). | «Контакт-центр» — нельзя проверить одним критерием. |
| C2 | **Единая бизнес-ценность** | Даёт ли функция ровно один проверяемый эффект? | `opt-out-handling` — обработка отказа от рассылки. | «Обзвон с аналитикой и записью» — три ценности. |
| C3 | **Параметризуемость без дробления** | Есть ли у функции собственные параметры, но дальнейшее деление теряет смысл проверки? | `predictive-dialing` (params: `dial_ratio`, `abandon_rate_limit`). | `dial_ratio` сам по себе — это параметр, а не функция. |
| C4 | **Назначаемый owner и evidence** | Можно ли назначить владельца и сослаться на доказательство (док, API, KB)? | `call-recording-capture` → Voice product + API записи. | «Хорошее качество связи» — нет однозначного owner/evidence. |
| C5 | **Отсутствие скрытой композиции** | Не скрывает ли функция 2+ независимых правила/политики, которые меняются по отдельности? | `recording-retention-policy` отделена от `recording-access-control`. | «Запись с хранением и доступом» — две политики в одной. |

Правило применения: если функция проходит C1–C4, но нарушает C5, её нужно
**разделить** на несколько атомарных функций (как `call-recording`: capture →
retention → access-control). Если требуется отдельная политика, SLA или
compliance-review, это, согласно глоссарию, всё равно atomic function **плюс
overlay**, а не новый domain.

## Соглашения по параметрам

Каждый параметр помечается полем `origin`:

| `origin` | Что означает | Как фиксировать |
| --- | --- | --- |
| `standard` | Параметр устойчив в международной практике телекома/CCaaS (есть у нескольких vendor и/или в стандартах). | Имя и семантику не менять; диапазон сверять с vendor docs. |
| `mango-custom` | Параметр специфичен для продуктовой реальности Mango или для локального рынка РФ. | Фиксировать в `classification-glossary.md`/`kb/` и помечать как кандидат на стандартизацию. |

Практическое правило: `standard`-параметры обеспечивают сопоставимость с
конкурентами и benchmark, `mango-custom`-параметры — точность под продукт. Если
параметр встречается у трёх и более источников (TM Forum + два vendor) — это
`standard`; иначе — `mango-custom` до подтверждения.

---

## 📦 Domain: voice-ucaas

Телефония и унифицированные коммуникации. Детализируем три capability:
`ivr-voice-menu`, `call-recording`, `cloud-pbx`.

### 🔹 Capability: ivr-voice-menu (Голосовое меню IVR и автоинформирование)

`classification.md` row 4 · Mango status: Есть.

#### Feature: ivr-scenarios (Сценарии голосового меню)

```yaml
domain: "voice-ucaas"
capability: "ivr-voice-menu"
feature: "ivr-scenarios"
atomic_functions:
  - id: "ivr-menu-navigation"
    name: "Навигация по голосовому меню"
    description: "Воспроизведение узла меню и маршрутизация по выбору абонента."
    parameters:
      - name: "menu_tree"
        type: "string"
        range: "ссылка на дерево узлов (id сценария)"
        origin: "standard"
        description: "Структура узлов и переходов меню."
      - name: "timeout_action"
        type: "enum"
        range: "repeat | route-to-operator | hangup"
        origin: "standard"
        description: "Действие при отсутствии ввода."
      - name: "max_invalid_attempts"
        type: "int"
        range: "1–5"
        origin: "standard"
        description: "Лимит неверных нажатий до fallback."
    international_sources:
      - "TM Forum SID: Customer Interaction ABE"
      - "Amazon Connect: Contact flows (Get customer input)"
    example_requirements:
      - "Система должна предоставлять голосовое меню (IVR) с маршрутизацией по пунктам (TZ 3, 16)."
    related_nfr: ["B8: юзабилити (понятность меню)"]
  - id: "dtmf-input-collection"
    name: "Сбор DTMF-ввода"
    description: "Приём тонального ввода абонента (тоновый режим)."
    parameters:
      - name: "digit_count"
        type: "int"
        range: "1–32"
        origin: "standard"
        description: "Ожидаемое число цифр."
      - name: "terminator_key"
        type: "enum"
        range: "# | * | none"
        origin: "standard"
        description: "Клавиша завершения ввода."
      - name: "interdigit_timeout_ms"
        type: "duration"
        range: "1000–10000 мс"
        origin: "standard"
        description: "Пауза между цифрами до завершения."
    international_sources:
      - "ITU-T Q.23/Q.24: DTMF signalling"
      - "Cisco UCCE: IVR Get Digits / Collect Digits"
    example_requirements:
      - "Меню должно поддерживать тоновый режим выбора пункта (TZ 11, 18)."
    related_nfr: ["B8: юзабилити"]
  - id: "voice-prompt-playback"
    name: "Воспроизведение голосового промпта"
    description: "Проигрывание подсказки из аудиофайла или синтеза речи."
    parameters:
      - name: "prompt_id"
        type: "string"
        range: "id записи/шаблона"
        origin: "standard"
        description: "Идентификатор промпта."
      - name: "playback_source"
        type: "enum"
        range: "audio-file | tts"
        origin: "standard"
        description: "Источник озвучивания."
      - name: "language"
        type: "enum"
        range: "ru | en | … (ISO 639-1)"
        origin: "mango-custom"
        description: "Язык воспроизведения."
    international_sources:
      - "TM Forum SID: Customer Interaction ABE"
      - "Amazon Connect: Play prompt block"
    example_requirements:
      - "Автоинформатор должен проигрывать заранее записанное сообщение (TZ 19, 26)."
    related_nfr: ["B8: локализация/юзабилити"]
```

#### Feature: auto-secretary (Автосекретарь и расписание)

```yaml
domain: "voice-ucaas"
capability: "ivr-voice-menu"
feature: "auto-secretary"
atomic_functions:
  - id: "schedule-based-greeting"
    name: "Приветствие по расписанию"
    description: "Выбор приветствия в зависимости от рабочего времени и праздников."
    parameters:
      - name: "schedule_id"
        type: "string"
        range: "id расписания"
        origin: "standard"
        description: "Рабочие/нерабочие интервалы."
      - name: "holiday_calendar"
        type: "string"
        range: "id календаря"
        origin: "mango-custom"
        description: "Производственный календарь РФ."
      - name: "default_greeting_id"
        type: "string"
        range: "id приветствия"
        origin: "standard"
        description: "Приветствие по умолчанию."
    international_sources:
      - "TM Forum SID: Customer Interaction ABE"
      - "Cisco UCCE: Time-of-day / business-hours routing"
    example_requirements:
      - "Автосекретарь должен отвечать разными приветствиями в рабочее и нерабочее время (TZ 13, 20)."
    related_nfr: ["B8: юзабилити"]
  - id: "auto-secretary-routing"
    name: "Маршрутизация автосекретаря"
    description: "Перевод по выбранному пункту автосекретаря."
    parameters:
      - name: "dtmf_map"
        type: "list"
        range: "пары «цифра → назначение»"
        origin: "standard"
        description: "Соответствие нажатия и цели перевода."
      - name: "invalid_input_action"
        type: "enum"
        range: "repeat | route-to-operator | hangup"
        origin: "standard"
        description: "Реакция на неверный ввод."
    international_sources:
      - "Amazon Connect: Contact flows"
      - "Genesys: Routing strategies"
    example_requirements:
      - "При выборе «1» вызов должен переводиться в отдел продаж (TZ 16)."
    related_nfr: ["B8: юзабилити"]
  - id: "operator-fallback-transfer"
    name: "Fallback-перевод на оператора"
    description: "Перевод на живого оператора при таймауте или ошибке."
    parameters:
      - name: "fallback_target"
        type: "string"
        range: "id очереди/группы"
        origin: "standard"
        description: "Куда переводить при fallback."
      - name: "transfer_timeout_s"
        type: "duration"
        range: "5–60 с"
        origin: "standard"
        description: "Таймаут до fallback."
    international_sources:
      - "Cisco UCCE: Queue / RONA handling"
      - "TM Forum SID: Customer Interaction ABE"
    example_requirements:
      - "Если абонент не выбрал пункт меню, звонок должен уйти на оператора (TZ 18)."
    related_nfr: ["B1: доступность", "B8: юзабилити"]
```

### 🔹 Capability: call-recording (Запись разговоров и журналирование)

`classification.md` row 6 · Mango status: Есть.

#### Feature: recording-capture (Захват и согласие на запись)

```yaml
domain: "voice-ucaas"
capability: "call-recording"
feature: "recording-capture"
atomic_functions:
  - id: "call-recording-capture"
    name: "Захват записи разговора"
    description: "Запись аудио вызова по заданному правилу."
    parameters:
      - name: "trigger_mode"
        type: "enum"
        range: "all | on-demand | rule-based"
        origin: "standard"
        description: "Когда включается запись."
      - name: "audio_format"
        type: "enum"
        range: "mp3 | wav | opus"
        origin: "standard"
        description: "Формат аудиофайла."
      - name: "channel_mode"
        type: "enum"
        range: "mono | stereo"
        origin: "standard"
        description: "Раздельные дорожки абонента и оператора."
    international_sources:
      - "TM Forum SID: Service Usage / Customer Interaction"
      - "Genesys: Call Recording (GIR) capture modes"
    example_requirements:
      - "Система должна записывать все входящие и исходящие разговоры (TZ 3, 14)."
    related_nfr: ["B5: хранение записей", "B2: производительность (одновременные записи)"]
  - id: "recording-pause-resume"
    name: "Пауза/возобновление записи"
    description: "Приостановка записи для маскирования чувствительных данных."
    parameters:
      - name: "pause_trigger"
        type: "enum"
        range: "manual | api | rule-based"
        origin: "standard"
        description: "Источник паузы."
      - name: "masked_segment_tag"
        type: "string"
        range: "метка маскированного сегмента"
        origin: "mango-custom"
        description: "Тег для аудита маскирования (ПДн/платёжные данные)."
    international_sources:
      - "Genesys: Recording pause/resume for sensitive data"
      - "Amazon Connect: Suppress sensitive data in recordings"
    example_requirements:
      - "При вводе платёжных данных запись должна приостанавливаться (TZ 24 — защита ПДн)."
    related_nfr: ["B3: ИБ и защита ПДн (152-ФЗ)"]
  - id: "recording-consent-announcement"
    name: "Уведомление о записи"
    description: "Проигрывание предупреждения о том, что разговор записывается."
    parameters:
      - name: "announcement_id"
        type: "string"
        range: "id сообщения"
        origin: "standard"
        description: "Промпт уведомления."
      - name: "consent_required_flag"
        type: "bool"
        range: "true | false"
        origin: "mango-custom"
        description: "Требуется ли явное согласие."
    international_sources:
      - "TM Forum SID: Customer Interaction ABE"
      - "Cisco UCCE: Recording disclaimer prompt"
    example_requirements:
      - "Абонента нужно уведомлять о записи разговора в начале вызова (TZ 24, 30)."
    related_nfr: ["B3: защита ПДн", "B10: compliance"]
```

#### Feature: recording-governance (Хранение, доступ, выгрузка)

```yaml
domain: "voice-ucaas"
capability: "call-recording"
feature: "recording-governance"
atomic_functions:
  - id: "recording-retention-policy"
    name: "Политика хранения записей"
    description: "Срок и место хранения записей и правило удаления."
    parameters:
      - name: "retention_days"
        type: "int"
        range: "30–1095 дней (≈1–36 мес.)"
        origin: "standard"
        description: "Срок хранения; типовые ТЗ требуют 6–12 мес."
      - name: "storage_target"
        type: "enum"
        range: "cloud | ftp | s3 | on-prem"
        origin: "standard"
        description: "Место хранения."
      - name: "deletion_mode"
        type: "enum"
        range: "auto-expire | manual | legal-hold"
        origin: "standard"
        description: "Способ удаления по истечении срока."
    international_sources:
      - "TM Forum SID: Service Usage"
      - "Genesys: Recording retention / storage policies"
    example_requirements:
      - "Записи должны храниться не менее 6/12 месяцев с выгрузкой на FTP (TZ 11, 13, 15)."
    related_nfr: ["B5: хранение записей", "B4: размещение в РФ"]
  - id: "recording-access-control"
    name: "Контроль доступа к записям"
    description: "Ролевой доступ и маскирование при прослушивании/выгрузке."
    parameters:
      - name: "role_id"
        type: "string"
        range: "id роли"
        origin: "standard"
        description: "Роль, имеющая доступ."
      - name: "masking_policy"
        type: "enum"
        range: "none | partial | full"
        origin: "mango-custom"
        description: "Маскирование чувствительных полей."
      - name: "audit_log_flag"
        type: "bool"
        range: "true | false"
        origin: "standard"
        description: "Журналирование доступа к записи."
    international_sources:
      - "ISO/IEC 27001: access control (A.5/A.8)"
      - "Genesys: Recording access permissions"
    example_requirements:
      - "Доступ к записям должен быть ролевым, с журналом доступа (TZ 20, 21)."
    related_nfr: ["B3: ИБ и защита ПДн", "B7: документация (схема доступа)"]
  - id: "recording-export"
    name: "Выгрузка записей"
    description: "Экспорт записей за период во внешнее хранилище/систему."
    parameters:
      - name: "date_range"
        type: "string"
        range: "ISO8601 интервал"
        origin: "standard"
        description: "Период выгрузки."
      - name: "export_format"
        type: "enum"
        range: "zip | csv-index | api-stream"
        origin: "standard"
        description: "Формат пакета выгрузки."
      - name: "transport"
        type: "enum"
        range: "ftp | api | download"
        origin: "standard"
        description: "Канал передачи."
    international_sources:
      - "TM Forum Open API: TMF635 Usage Management"
      - "Amazon Connect: Recording export to S3"
    example_requirements:
      - "Должна быть возможность выгрузки записей для аудита (TZ 27, 30)."
    related_nfr: ["B5: хранение записей", "B7: документация поставщика"]
```

### 🔹 Capability: cloud-pbx (Виртуальная / облачная АТС)

`classification.md` row 1 · Mango status: Есть.

#### Feature: call-routing-rules (Правила обработки звонков)

```yaml
domain: "voice-ucaas"
capability: "cloud-pbx"
feature: "call-routing-rules"
atomic_functions:
  - id: "working-hours-routing"
    name: "Маршрутизация по рабочему времени"
    description: "Разная маршрутизация в рабочее и нерабочее время."
    parameters:
      - name: "schedule_id"
        type: "string"
        range: "id расписания"
        origin: "standard"
        description: "Интервалы работы."
      - name: "holiday_calendar"
        type: "string"
        range: "id календаря"
        origin: "mango-custom"
        description: "Производственный календарь РФ."
      - name: "after_hours_target"
        type: "string"
        range: "id назначения"
        origin: "standard"
        description: "Куда направлять вне рабочего времени."
    international_sources:
      - "TM Forum SID: Customer Interaction ABE"
      - "Cisco UCCE: Time-of-day routing"
    example_requirements:
      - "Вне рабочего времени звонок должен направляться на автоответчик/голосовую почту (TZ 11, 20)."
    related_nfr: ["B1: доступность"]
  - id: "ring-strategy"
    name: "Стратегия дозвона группы"
    description: "Последовательный или одновременный вызов участников группы."
    parameters:
      - name: "ring_strategy"
        type: "enum"
        range: "sequential | simultaneous | round-robin"
        origin: "standard"
        description: "Порядок дозвона."
      - name: "ring_timeout_s"
        type: "duration"
        range: "5–60 с"
        origin: "standard"
        description: "Время дозвона до перехода."
    international_sources:
      - "TM Forum SID: Customer Interaction ABE"
      - "Cisco UCCE: Hunt group / agent selection"
    example_requirements:
      - "Звонок в отдел должен звонить всем сотрудникам одновременно (TZ 3)."
    related_nfr: ["B1: доступность"]
  - id: "blacklist-whitelist-filtering"
    name: "Фильтрация по чёрному/белому списку"
    description: "Блокировка или приоритет вызовов по списку номеров."
    parameters:
      - name: "list_id"
        type: "string"
        range: "id списка"
        origin: "standard"
        description: "Идентификатор списка номеров."
      - name: "match_action"
        type: "enum"
        range: "block | allow | route"
        origin: "standard"
        description: "Действие при совпадении."
    international_sources:
      - "TM Forum SID: Customer Interaction ABE"
      - "Amazon Connect: Contact flow (Check call attributes)"
    example_requirements:
      - "Система должна блокировать звонки с нежелательных номеров (TZ 2)."
    related_nfr: ["B3: ИБ"]
```

#### Feature: extension-management (Внутренние номера и переадресация)

```yaml
domain: "voice-ucaas"
capability: "cloud-pbx"
feature: "extension-management"
atomic_functions:
  - id: "extension-provisioning"
    name: "Назначение внутреннего номера"
    description: "Создание внутреннего номера и привязка к устройству/SIP."
    parameters:
      - name: "extension_range"
        type: "string"
        range: "диапазон, напр. 100–199"
        origin: "standard"
        description: "Диапазон внутренних номеров."
      - name: "sip_profile"
        type: "string"
        range: "id SIP-профиля"
        origin: "standard"
        description: "Профиль регистрации устройства."
      - name: "device_binding"
        type: "enum"
        range: "softphone | desk-phone | mobile"
        origin: "standard"
        description: "Тип привязанного устройства."
    international_sources:
      - "IETF RFC 3261: SIP (registration)"
      - "TM Forum SID: Resource ABE"
    example_requirements:
      - "Каждому сотруднику должен назначаться внутренний номер (TZ 1, 10)."
    related_nfr: ["B2: масштабируемость (число абонентов)"]
  - id: "call-transfer"
    name: "Перевод вызова"
    description: "Слепой или сопровождаемый перевод активного вызова."
    parameters:
      - name: "transfer_type"
        type: "enum"
        range: "blind | attended"
        origin: "standard"
        description: "Тип перевода."
      - name: "transfer_target"
        type: "string"
        range: "номер/внутренний/очередь"
        origin: "standard"
        description: "Цель перевода."
    international_sources:
      - "IETF RFC 5589: SIP Call Control – Transfer"
      - "Cisco UCCE: Consult/Blind transfer"
    example_requirements:
      - "Оператор должен переводить вызов на другого сотрудника (TZ 3, 11)."
    related_nfr: ["B8: юзабилити"]
  - id: "voicemail-to-email"
    name: "Голосовая почта на email"
    description: "Доставка голосового сообщения на электронную почту."
    parameters:
      - name: "mailbox_id"
        type: "string"
        range: "id ящика"
        origin: "standard"
        description: "Голосовой ящик."
      - name: "delivery_format"
        type: "enum"
        range: "attachment | link | transcript"
        origin: "standard"
        description: "Формат доставки сообщения."
      - name: "notification_address"
        type: "string"
        range: "email"
        origin: "standard"
        description: "Адрес доставки."
    international_sources:
      - "TM Forum SID: Customer Interaction ABE"
      - "Amazon Connect: Voicemail (with transcription)"
    example_requirements:
      - "Пропущенные звонки/сообщения должны дублироваться на email (TZ 13)."
    related_nfr: ["B8: юзабилити"]
```

---

## 📦 Domain: contact-center

Контакт-центр и CCaaS. Детализируем три capability: `call-routing`,
`outbound-calling`, `quality-management`.

### 🔹 Capability: call-routing (Распределение звонков, очереди, маршрутизация)

`classification.md` row 5 · Mango status: Есть.

#### Feature: skill-based-routing (Маршрутизация по навыкам)

```yaml
domain: "contact-center"
capability: "call-routing"
feature: "skill-based-routing"
atomic_functions:
  - id: "skill-based-routing"
    name: "Маршрутизация по навыкам"
    description: "Выбор оператора по требуемому навыку и приоритету."
    parameters:
      - name: "skill_group"
        type: "string"
        range: "id группы навыков"
        origin: "standard"
        description: "Требуемый навык/очередь навыка."
      - name: "priority_weight"
        type: "int"
        range: "1–10"
        origin: "standard"
        description: "Приоритет при конкуренции очередей."
      - name: "proficiency_level"
        type: "int"
        range: "1–5"
        origin: "standard"
        description: "Минимальный уровень владения навыком."
    international_sources:
      - "Genesys: Skill-based routing"
      - "Cisco UCCE: Precision Routing (attributes)"
    example_requirements:
      - "Вызовы должны распределяться по навыкам операторов (skill-based) (TZ 3, 16)."
    related_nfr: ["B2: масштабируемость"]
  - id: "longest-idle-agent-selection"
    name: "Выбор наиболее свободного оператора"
    description: "Назначение вызова оператору с наибольшим временем простоя."
    parameters:
      - name: "idle_metric"
        type: "enum"
        range: "longest-idle | fewest-calls"
        origin: "standard"
        description: "Метрика выбора оператора."
      - name: "tie_breaker"
        type: "enum"
        range: "random | priority | seniority"
        origin: "standard"
        description: "Разрешение равенства метрики."
    international_sources:
      - "Genesys: Agent selection (Longest Available Agent)"
      - "Amazon Connect: Routing profiles"
    example_requirements:
      - "Вызов должен уходить наиболее свободному оператору для равномерной нагрузки (TZ 16)."
    related_nfr: ["B2: производительность"]
  - id: "last-agent-routing"
    name: "Маршрутизация на последнего оператора"
    description: "Привязка повторного обращения к ранее обслужившему оператору."
    parameters:
      - name: "stickiness_window_h"
        type: "duration"
        range: "1–168 ч"
        origin: "standard"
        description: "Окно «прилипания» к оператору."
      - name: "fallback_strategy"
        type: "enum"
        range: "skill | longest-idle | queue"
        origin: "standard"
        description: "Что делать, если оператор недоступен."
    international_sources:
      - "Genesys: Last Called Agent routing"
      - "Cisco UCCE: Agent affinity"
    example_requirements:
      - "Повторный звонок клиента желательно направлять тому же оператору (TZ 13)."
    related_nfr: ["B8: юзабилити (continuity)"]
```

#### Feature: queue-management (Управление очередями)

```yaml
domain: "contact-center"
capability: "call-routing"
feature: "queue-management"
atomic_functions:
  - id: "queue-prioritization"
    name: "Приоритизация очереди"
    description: "Назначение приоритета и порога SLA для очереди."
    parameters:
      - name: "priority_level"
        type: "int"
        range: "1–10"
        origin: "standard"
        description: "Приоритет очереди."
      - name: "sla_threshold_s"
        type: "duration"
        range: "10–120 с"
        origin: "standard"
        description: "Целевое время ответа (service level)."
    international_sources:
      - "Genesys: Virtual Queue / priority"
      - "Cisco UCCE: Precision Queue priority"
    example_requirements:
      - "VIP-клиенты должны обслуживаться в приоритетной очереди (TZ 13, 16)."
    related_nfr: ["B1: SLA уровня обслуживания"]
  - id: "wait-announcement"
    name: "Объявление позиции и времени ожидания"
    description: "Информирование абонента о позиции в очереди и ожидании."
    parameters:
      - name: "announce_interval_s"
        type: "duration"
        range: "15–120 с"
        origin: "standard"
        description: "Частота объявлений."
      - name: "announce_position_flag"
        type: "bool"
        range: "true | false"
        origin: "standard"
        description: "Озвучивать позицию в очереди."
      - name: "announce_eta_flag"
        type: "bool"
        range: "true | false"
        origin: "standard"
        description: "Озвучивать ожидаемое время."
    international_sources:
      - "Amazon Connect: Queue metrics / prompts"
      - "Genesys: Estimated Wait Time announcements"
    example_requirements:
      - "Абоненту в очереди нужно сообщать его позицию и время ожидания (TZ 16, 18)."
    related_nfr: ["B8: юзабилити"]
  - id: "queue-overflow-routing"
    name: "Перелив очереди"
    description: "Перенаправление при переполнении или превышении ожидания."
    parameters:
      - name: "overflow_target"
        type: "string"
        range: "id очереди/назначения"
        origin: "standard"
        description: "Куда переливать вызовы."
      - name: "max_queue_size"
        type: "int"
        range: "1–1000"
        origin: "standard"
        description: "Максимум вызовов в очереди."
      - name: "abandon_threshold_s"
        type: "duration"
        range: "5–300 с"
        origin: "standard"
        description: "Порог ожидания до перелива/callback."
    international_sources:
      - "Genesys: Overflow routing"
      - "Cisco UCCE: Queue overflow / RONA"
    example_requirements:
      - "При переполнении очереди нужно предлагать обратный звонок (callback) (TZ 9, 18)."
    related_nfr: ["B1: доступность", "B2: масштабируемость"]
```

### 🔹 Capability: outbound-calling (Исходящий обзвон и кампании)

`classification.md` row 13 · Mango status: Есть.

#### Feature: campaign-management (Режимы набора кампании)

```yaml
domain: "contact-center"
capability: "outbound-calling"
feature: "campaign-management"
atomic_functions:
  - id: "predictive-dialing"
    name: "Предиктивный набор"
    description: "Автоматический набор с предсказанием доступности оператора."
    parameters:
      - name: "dial_ratio"
        type: "float"
        range: "1.0–5.0"
        origin: "standard"
        description: "Соотношение наборов к операторам."
      - name: "abandon_rate_limit"
        type: "percent"
        range: "0–5%"
        origin: "standard"
        description: "Макс. доля сброшенных звонков."
      - name: "pacing_algorithm"
        type: "enum"
        range: "agent-availability | abandon-target"
        origin: "standard"
        description: "Алгоритм регулирования темпа."
    international_sources:
      - "Genesys: Outbound Dialing Modes (Predictive)"
      - "Cisco UCCE/Outbound Option: Predictive dialer"
    example_requirements:
      - "Скорость набора должна регулироваться автоматически по доступности операторов; сброшенных не более 3% (TZ 1, 16)."
    related_nfr: ["B2: производительность", "B10: compliance (реклама/abandon)"]
  - id: "progressive-dialing"
    name: "Прогрессивный набор"
    description: "Набор следующего контакта, как только освобождается оператор."
    parameters:
      - name: "lines_per_agent"
        type: "float"
        range: "1.0–2.0"
        origin: "standard"
        description: "Линий на оператора."
      - name: "wrap_up_time_s"
        type: "duration"
        range: "0–120 с"
        origin: "standard"
        description: "Пауза постобработки между вызовами."
    international_sources:
      - "Genesys: Outbound Dialing Modes (Progressive)"
      - "Amazon Connect: High-volume outbound (progressive)"
    example_requirements:
      - "Робот/оператор должен набирать следующий контакт сразу после завершения (TZ 6, 17)."
    related_nfr: ["B2: производительность"]
  - id: "preview-dialing"
    name: "Набор с предпросмотром"
    description: "Показ карточки контакта оператору до набора."
    parameters:
      - name: "preview_timeout_s"
        type: "duration"
        range: "5–60 с"
        origin: "standard"
        description: "Время на предпросмотр до автонабора."
      - name: "skip_allowed_flag"
        type: "bool"
        range: "true | false"
        origin: "standard"
        description: "Можно ли пропустить контакт."
    international_sources:
      - "Genesys: Outbound Dialing Modes (Preview)"
      - "Cisco UCCE/Outbound Option: Preview dialing"
    example_requirements:
      - "Перед звонком оператор должен видеть карточку клиента (TZ 14)."
    related_nfr: ["B8: юзабилити"]
```

#### Feature: campaign-execution (Соответствие правилам и результаты обзвона)

```yaml
domain: "contact-center"
capability: "outbound-calling"
feature: "campaign-execution"
atomic_functions:
  - id: "timezone-aware-dialing"
    name: "Набор с учётом часового пояса"
    description: "Ограничение времени звонков локальным разрешённым окном."
    parameters:
      - name: "allowed_window_local"
        type: "string"
        range: "напр. 09:00–20:00"
        origin: "standard"
        description: "Разрешённое окно по местному времени."
      - name: "timezone_source"
        type: "enum"
        range: "phone-prefix | crm-field | manual"
        origin: "mango-custom"
        description: "Источник определения часового пояса."
    international_sources:
      - "Genesys: Outbound time zone / contact rules"
      - "Cisco UCCE/Outbound Option: Dialing time ranges"
    example_requirements:
      - "Обзвон должен учитывать часовой пояс абонента (TZ 8, 17)."
    related_nfr: ["B10: compliance", "B9: НПА связи"]
  - id: "answering-machine-detection"
    name: "Определение автоответчика (AMD)"
    description: "Различение живого ответа и автоответчика и выбор действия."
    parameters:
      - name: "detection_mode"
        type: "enum"
        range: "fast | accurate"
        origin: "standard"
        description: "Профиль точности/скорости детекции."
      - name: "max_analysis_ms"
        type: "duration"
        range: "1000–5000 мс"
        origin: "standard"
        description: "Окно анализа начала ответа."
      - name: "amd_action"
        type: "enum"
        range: "drop | leave-message | route-to-agent"
        origin: "standard"
        description: "Действие при автоответчике."
    international_sources:
      - "Genesys: Answering Machine Detection"
      - "Amazon Connect: Voice ID / call analysis (AMD)"
    example_requirements:
      - "Робот должен отличать ответ человека от автоответчика (TZ 6, 17)."
    related_nfr: ["B2: производительность", "B8: качество распознавания"]
  - id: "disposition-code-assignment"
    name: "Присвоение кода результата"
    description: "Фиксация итога контакта кодом результата."
    parameters:
      - name: "code_list"
        type: "list"
        range: "справочник кодов результата"
        origin: "standard"
        description: "Допустимые исходы (дозвонился, отказ, перезвонить…)."
      - name: "auto_tagging"
        type: "bool"
        range: "true | false"
        origin: "mango-custom"
        description: "Автопростановка кода из событий."
      - name: "mandatory_flag"
        type: "bool"
        range: "true | false"
        origin: "standard"
        description: "Обязательность кода до завершения."
    international_sources:
      - "Genesys: Disposition codes / wrap-up"
      - "Amazon Connect: Contact attributes / disposition"
    example_requirements:
      - "Оператор должен фиксировать результат звонка из справочника статусов (TZ 13, 16)."
    related_nfr: ["B7: отчётность по кампании"]
```

### 🔹 Capability: quality-management (Управление качеством операторов / QM)

`classification.md` row 20 · Mango status: Есть.

#### Feature: scorecards (Оценка по чек-листам)

```yaml
domain: "contact-center"
capability: "quality-management"
feature: "scorecards"
atomic_functions:
  - id: "scorecard-evaluation"
    name: "Оценка по чек-листу"
    description: "Оценка обращения по чек-листу с выборкой."
    parameters:
      - name: "checklist_id"
        type: "string"
        range: "id чек-листа"
        origin: "standard"
        description: "Критерии оценки."
      - name: "sampling_rate"
        type: "percent"
        range: "1–100%"
        origin: "standard"
        description: "Доля обращений на оценку."
      - name: "scoring_scale"
        type: "enum"
        range: "binary | weighted | 0-100"
        origin: "standard"
        description: "Шкала оценки."
    international_sources:
      - "Genesys: Quality Management evaluations"
      - "Cisco Webex CC: Quality Management scorecards"
    example_requirements:
      - "Супервизор должен оценивать звонки по чек-листу качества (TZ 3, 16)."
    related_nfr: ["B7: отчётность"]
  - id: "calibration-session"
    name: "Калибровочная сессия"
    description: "Сверка оценок разных экспертов по одному обращению."
    parameters:
      - name: "session_id"
        type: "string"
        range: "id сессии"
        origin: "standard"
        description: "Калибровочная сессия."
      - name: "variance_threshold"
        type: "percent"
        range: "5–20%"
        origin: "standard"
        description: "Допустимый разброс оценок."
    international_sources:
      - "Genesys: Calibration"
      - "Cisco Webex CC: Evaluation calibration"
    example_requirements:
      - "Оценки разных экспертов должны сверяться для единообразия (TZ 20)."
    related_nfr: ["B8: согласованность процесса"]
  - id: "evaluation-appeal"
    name: "Апелляция оценки"
    description: "Оспаривание оценки оператором с пересмотром."
    parameters:
      - name: "case_id"
        type: "string"
        range: "id обращения"
        origin: "standard"
        description: "Спорная оценка."
      - name: "reviewer_role"
        type: "string"
        range: "id роли ревьюера"
        origin: "standard"
        description: "Кто пересматривает."
      - name: "sla_days"
        type: "int"
        range: "1–14 дней"
        origin: "mango-custom"
        description: "Срок рассмотрения апелляции."
    international_sources:
      - "Genesys: Evaluation dispute workflow"
      - "BABOK: Solution Evaluation"
    example_requirements:
      - "Оператор должен иметь возможность оспорить оценку качества (TZ 20)."
    related_nfr: ["B8: процесс/юзабилити"]
```

#### Feature: live-monitoring (Мониторинг в реальном времени)

```yaml
domain: "contact-center"
capability: "quality-management"
feature: "live-monitoring"
atomic_functions:
  - id: "silent-monitoring"
    name: "Тихое подключение"
    description: "Прослушивание разговора без вмешательства."
    parameters:
      - name: "session_id"
        type: "string"
        range: "id сессии"
        origin: "standard"
        description: "Контролируемый вызов."
      - name: "notify_agent_flag"
        type: "bool"
        range: "true | false"
        origin: "standard"
        description: "Уведомлять ли оператора о контроле."
    international_sources:
      - "Cisco UCCE: Silent Monitoring"
      - "Genesys: Supervisor monitor"
    example_requirements:
      - "Супервизор должен иметь возможность прослушивать звонок в реальном времени (TZ 1, 4)."
    related_nfr: ["B3: ИБ (журнал контроля)"]
  - id: "whisper-coaching"
    name: "Режим «шёпот»"
    description: "Подсказка оператору, не слышимая абоненту."
    parameters:
      - name: "session_id"
        type: "string"
        range: "id сессии"
        origin: "standard"
        description: "Контролируемый вызов."
      - name: "target"
        type: "enum"
        range: "agent"
        origin: "standard"
        description: "Кому адресована подсказка."
    international_sources:
      - "Cisco UCCE: Whisper coaching"
      - "Genesys: Coach mode"
    example_requirements:
      - "Супервизор должен подсказывать оператору в режиме «шёпот» (TZ 2, 13)."
    related_nfr: ["B8: юзабилити"]
  - id: "barge-in"
    name: "Перехват/подключение к разговору"
    description: "Подключение супервизора к активному разговору."
    parameters:
      - name: "session_id"
        type: "string"
        range: "id сессии"
        origin: "standard"
        description: "Контролируемый вызов."
      - name: "takeover_mode"
        type: "enum"
        range: "three-way | takeover"
        origin: "standard"
        description: "Совместный разговор или перехват."
    international_sources:
      - "Cisco UCCE: Barge-In"
      - "Genesys: Supervisor barge-in"
    example_requirements:
      - "Супервизор должен иметь возможность вмешаться в разговор (перехват) (TZ 2, 17)."
    related_nfr: ["B8: юзабилити", "B3: ИБ"]
```

---

## 📦 Domain: digital-channels

Цифровые каналы и коммуникации. Детализируем три capability:
`omnichannel-messaging`, `website-chat`, `sms-messaging`.

### 🔹 Capability: omnichannel-messaging (Омниканальные коммуникации)

`classification.md` row 14 · Mango status: Есть.

#### Feature: channel-integration (Подключение каналов)

```yaml
domain: "digital-channels"
capability: "omnichannel-messaging"
feature: "channel-integration"
atomic_functions:
  - id: "channel-ingestion"
    name: "Приём сообщений из канала"
    description: "Подключение мессенджера/соцсети/email и приём входящих."
    parameters:
      - name: "channel_type"
        type: "enum"
        range: "whatsapp | telegram | vk | max | ok | avito | email"
        origin: "mango-custom"
        description: "Тип подключаемого канала (локальный набор РФ)."
      - name: "account_credentials"
        type: "string"
        range: "id учётных данных канала"
        origin: "standard"
        description: "Авторизация в канале."
      - name: "inbound_webhook"
        type: "string"
        range: "URL"
        origin: "standard"
        description: "Точка приёма входящих событий."
    international_sources:
      - "TM Forum SID: Customer Interaction ABE"
      - "Amazon Connect: Chat / messaging channels"
    example_requirements:
      - "Единое окно оператора должно принимать обращения из WhatsApp/Telegram/VK/email (TZ 4, 16)."
    related_nfr: ["B2: масштабируемость каналов"]
  - id: "outbound-message-dispatch"
    name: "Отправка исходящего сообщения"
    description: "Отправка сообщения в канал с учётом окна сессии."
    parameters:
      - name: "channel_type"
        type: "enum"
        range: "whatsapp | telegram | vk | max | ok | avito | email"
        origin: "mango-custom"
        description: "Канал отправки."
      - name: "message_template_id"
        type: "string"
        range: "id шаблона"
        origin: "standard"
        description: "Шаблон сообщения (для каналов с модерацией)."
      - name: "session_window_h"
        type: "duration"
        range: "0–24 ч"
        origin: "standard"
        description: "Окно сервисной сессии канала."
    international_sources:
      - "TM Forum SID: Customer Interaction ABE"
      - "Amazon Connect: Outbound campaigns (messaging)"
    example_requirements:
      - "Оператор должен отвечать клиенту в том же канале, откуда пришло обращение (TZ 9, 16)."
    related_nfr: ["B10: compliance (шаблоны/согласие)"]
  - id: "message-template-management"
    name: "Управление шаблонами сообщений"
    description: "Ведение и согласование шаблонов исходящих сообщений."
    parameters:
      - name: "template_id"
        type: "string"
        range: "id шаблона"
        origin: "standard"
        description: "Идентификатор шаблона."
      - name: "approval_status"
        type: "enum"
        range: "draft | submitted | approved | rejected"
        origin: "standard"
        description: "Статус модерации шаблона."
      - name: "variable_set"
        type: "list"
        range: "список подстановок"
        origin: "standard"
        description: "Переменные персонализации."
    international_sources:
      - "TM Forum SID: Customer Interaction ABE"
      - "BABOK: Requirements (template/business rules)"
    example_requirements:
      - "Уведомления о статусе заказа должны рассылаться по согласованным шаблонам (TZ 19, 28)."
    related_nfr: ["B10: реклама/согласие"]
```

#### Feature: unified-inbox (Единое окно и история)

```yaml
domain: "digital-channels"
capability: "omnichannel-messaging"
feature: "unified-inbox"
atomic_functions:
  - id: "conversation-assignment"
    name: "Назначение диалога оператору"
    description: "Распределение входящего диалога по правилам."
    parameters:
      - name: "routing_rules"
        type: "string"
        range: "id набора правил"
        origin: "standard"
        description: "Правила распределения диалогов."
      - name: "assignment_mode"
        type: "enum"
        range: "push | pull"
        origin: "standard"
        description: "Автоназначение или забор оператором."
    international_sources:
      - "Genesys: Digital routing"
      - "Amazon Connect: Chat routing profiles"
    example_requirements:
      - "Чаты должны распределяться между операторами автоматически (TZ 9, 16)."
    related_nfr: ["B2: масштабируемость"]
  - id: "cross-channel-history-merge"
    name: "Объединение истории по каналам"
    description: "Сшивка истории контактов клиента из разных каналов."
    parameters:
      - name: "customer_key"
        type: "string"
        range: "телефон | email | crm-id"
        origin: "standard"
        description: "Ключ объединения клиента."
      - name: "merge_strategy"
        type: "enum"
        range: "by-identifier | by-crm-link"
        origin: "mango-custom"
        description: "Способ сшивки идентичности."
    international_sources:
      - "TM Forum SID: Party / Customer ABE"
      - "Genesys: Unified customer history"
    example_requirements:
      - "В карточке клиента должна быть видна история обращений из всех каналов (TZ 16, 24)."
    related_nfr: ["B3: защита ПДн"]
  - id: "conversation-disposition"
    name: "Закрытие диалога с результатом"
    description: "Фиксация итога диалога и автозакрытие по неактивности."
    parameters:
      - name: "disposition_code"
        type: "list"
        range: "справочник кодов"
        origin: "standard"
        description: "Итог диалога."
      - name: "auto_close_timeout_min"
        type: "duration"
        range: "5–1440 мин"
        origin: "standard"
        description: "Таймаут автозакрытия по неактивности."
    international_sources:
      - "Genesys: Digital interaction disposition"
      - "Amazon Connect: Contact attributes"
    example_requirements:
      - "Диалог без активности должен автоматически закрываться с фиксацией результата (TZ 16)."
    related_nfr: ["B7: отчётность"]
```

### 🔹 Capability: website-chat (Чат для сайта)

`classification.md` row 15 · Mango status: Есть.

#### Feature: chat-widget (Виджет чата)

```yaml
domain: "digital-channels"
capability: "website-chat"
feature: "chat-widget"
atomic_functions:
  - id: "chat-widget-embed"
    name: "Встраивание виджета чата"
    description: "Подключение виджета на сайт с правилами показа."
    parameters:
      - name: "widget_id"
        type: "string"
        range: "id виджета"
        origin: "standard"
        description: "Идентификатор виджета."
      - name: "trigger_rules"
        type: "string"
        range: "id набора правил"
        origin: "standard"
        description: "Условия показа виджета."
      - name: "display_position"
        type: "enum"
        range: "bottom-right | bottom-left | custom"
        origin: "standard"
        description: "Положение на странице."
    international_sources:
      - "TM Forum SID: Customer Interaction ABE"
      - "Amazon Connect: Hosted chat widget"
    example_requirements:
      - "На сайте должен быть онлайн-чат для обращений посетителей (TZ 9, 15)."
    related_nfr: ["B8: юзабилити"]
  - id: "proactive-invitation"
    name: "Проактивное приглашение в чат"
    description: "Автоприглашение посетителя по триггеру поведения."
    parameters:
      - name: "trigger_event"
        type: "enum"
        range: "time-on-page | scroll | exit-intent | url-match"
        origin: "standard"
        description: "Событие-триггер приглашения."
      - name: "delay_s"
        type: "duration"
        range: "0–120 с"
        origin: "standard"
        description: "Задержка до приглашения."
      - name: "audience_filter"
        type: "string"
        range: "id сегмента"
        origin: "mango-custom"
        description: "Кому показывать приглашение."
    international_sources:
      - "Genesys: Proactive chat (web engagement)"
      - "TM Forum SID: Customer Interaction ABE"
    example_requirements:
      - "Чат должен сам предлагать помощь посетителю на странице оплаты (TZ 15)."
    related_nfr: ["B8: юзабилити"]
  - id: "offline-message-capture"
    name: "Сбор сообщений в офлайне"
    description: "Приём заявки, когда операторы недоступны."
    parameters:
      - name: "form_fields"
        type: "list"
        range: "набор полей формы"
        origin: "standard"
        description: "Поля офлайн-формы."
      - name: "delivery_target"
        type: "enum"
        range: "email | crm | queue"
        origin: "standard"
        description: "Куда направлять офлайн-заявку."
    international_sources:
      - "TM Forum SID: Customer Interaction ABE"
      - "Amazon Connect: Chat (out-of-hours)"
    example_requirements:
      - "Вне рабочего времени чат должен принимать заявку с контактами (TZ 9)."
    related_nfr: ["B1: доступность"]
```

#### Feature: visitor-context (Контекст посетителя)

```yaml
domain: "digital-channels"
capability: "website-chat"
feature: "visitor-context"
atomic_functions:
  - id: "visitor-data-capture"
    name: "Сбор данных посетителя"
    description: "Сбор контекста посетителя с учётом согласия."
    parameters:
      - name: "consent_flag"
        type: "bool"
        range: "true | false"
        origin: "mango-custom"
        description: "Согласие на обработку (152-ФЗ)."
      - name: "field_set"
        type: "list"
        range: "имя, телефон, страница, источник"
        origin: "standard"
        description: "Собираемые поля."
      - name: "tracking_id"
        type: "string"
        range: "id посетителя/сессии"
        origin: "standard"
        description: "Идентификатор для аналитики."
    international_sources:
      - "TM Forum SID: Party / Customer ABE"
      - "Genesys: Web engagement context"
    example_requirements:
      - "Перед чатом нужно запросить контакты и согласие на обработку ПДн (TZ 15)."
    related_nfr: ["B3: защита ПДн (152-ФЗ)"]
  - id: "chat-to-call-escalation"
    name: "Эскалация чата в звонок"
    description: "Перевод текстового диалога в голосовой вызов с контекстом."
    parameters:
      - name: "escalation_target"
        type: "string"
        range: "id очереди/группы"
        origin: "standard"
        description: "Куда эскалировать."
      - name: "context_payload"
        type: "string"
        range: "ссылка на контекст диалога"
        origin: "standard"
        description: "Передаваемый контекст."
    international_sources:
      - "Genesys: Channel blending / escalation"
      - "Amazon Connect: Chat-to-voice"
    example_requirements:
      - "Из чата клиент должен иметь возможность заказать звонок оператора (TZ 9)."
    related_nfr: ["B8: юзабилити"]
  - id: "chat-transcript-delivery"
    name: "Доставка стенограммы чата"
    description: "Отправка истории диалога клиенту/в систему."
    parameters:
      - name: "delivery_channel"
        type: "enum"
        range: "email | crm"
        origin: "standard"
        description: "Канал доставки стенограммы."
      - name: "retention_days"
        type: "int"
        range: "30–730 дней"
        origin: "standard"
        description: "Срок хранения стенограммы."
    international_sources:
      - "TM Forum SID: Customer Interaction ABE"
      - "Amazon Connect: Chat transcript (S3)"
    example_requirements:
      - "История переписки должна сохраняться и быть доступной для аудита (TZ 15, 21)."
    related_nfr: ["B5: хранение переписок"]
```

### 🔹 Capability: sms-messaging (SMS-рассылки)

`classification.md` row 10 · Mango status: Есть.

#### Feature: bulk-sms (Массовые рассылки)

```yaml
domain: "digital-channels"
capability: "sms-messaging"
feature: "bulk-sms"
atomic_functions:
  - id: "bulk-sms-dispatch"
    name: "Массовая отправка SMS"
    description: "Рассылка SMS по списку контактов из шаблона."
    parameters:
      - name: "contact_list"
        type: "string"
        range: "id списка контактов"
        origin: "standard"
        description: "Аудитория рассылки."
      - name: "message_template"
        type: "string"
        range: "id шаблона"
        origin: "standard"
        description: "Текст с подстановками."
      - name: "throughput_limit_per_s"
        type: "int"
        range: "1–1000 сообщений/с"
        origin: "standard"
        description: "Ограничение скорости отправки."
    international_sources:
      - "ITU-T / 3GPP TS 23.040: SMS (SMPP-практика)"
      - "Amazon Pinpoint/SNS: SMS sending"
    example_requirements:
      - "Система должна выполнять SMS-рассылки и уведомления о статусе заказа (TZ 17, 28)."
    related_nfr: ["B2: производительность (throughput)"]
  - id: "sms-scheduling"
    name: "Планирование отправки SMS"
    description: "Отложенная отправка по расписанию и часовому поясу."
    parameters:
      - name: "send_window"
        type: "string"
        range: "напр. 09:00–21:00"
        origin: "standard"
        description: "Разрешённое окно отправки."
      - name: "timezone_source"
        type: "enum"
        range: "phone-prefix | crm-field | manual"
        origin: "mango-custom"
        description: "Источник часового пояса получателя."
    international_sources:
      - "Amazon Pinpoint: Scheduled campaigns"
      - "3GPP TS 23.040: SMS validity/timing"
    example_requirements:
      - "Рассылки не должны отправляться ночью с учётом часового пояса (TZ 19)."
    related_nfr: ["B10: реклама (38-ФЗ)"]
  - id: "sender-id-management"
    name: "Управление именем отправителя"
    description: "Регистрация и использование буквенного имени отправителя."
    parameters:
      - name: "sender_id"
        type: "string"
        range: "имя/номер отправителя"
        origin: "standard"
        description: "Подпись отправителя."
      - name: "alphanumeric_flag"
        type: "bool"
        range: "true | false"
        origin: "standard"
        description: "Буквенный или цифровой отправитель."
      - name: "registration_status"
        type: "enum"
        range: "pending | approved | rejected"
        origin: "mango-custom"
        description: "Статус регистрации имени у оператора."
    international_sources:
      - "3GPP TS 23.040: SMS originating address"
      - "ITU-T E.164: numbering (для цифровых отправителей)"
    example_requirements:
      - "SMS должны приходить от имени компании (буквенное имя отправителя) (TZ 17)."
    related_nfr: ["B9: НПА связи"]
```

#### Feature: sms-consent-delivery (Согласие и доставка)

```yaml
domain: "digital-channels"
capability: "sms-messaging"
feature: "sms-consent-delivery"
atomic_functions:
  - id: "opt-out-handling"
    name: "Обработка отказа от рассылки"
    description: "Отписка по стоп-слову и ведение списка подавления."
    parameters:
      - name: "stop_keyword"
        type: "list"
        range: "СТОП | STOP | …"
        origin: "standard"
        description: "Ключевые слова отписки."
      - name: "suppression_list"
        type: "string"
        range: "id списка подавления"
        origin: "standard"
        description: "Получатели, исключённые из рассылок."
      - name: "ack_message_id"
        type: "string"
        range: "id подтверждения"
        origin: "mango-custom"
        description: "Подтверждение отписки."
    international_sources:
      - "Amazon SNS/Pinpoint: SMS opt-out (STOP keyword)"
      - "3GPP TS 23.040: SMS messaging"
    example_requirements:
      - "Получатель должен иметь возможность отказаться от рассылки (TZ 19, 26)."
    related_nfr: ["B10: реклама (38-ФЗ)", "B3: ПДн"]
  - id: "advertising-consent-check"
    name: "Проверка согласия на рекламу"
    description: "Проверка наличия согласия до отправки рекламного SMS."
    parameters:
      - name: "consent_source"
        type: "enum"
        range: "web-form | crm | import | double-optin"
        origin: "mango-custom"
        description: "Источник согласия."
      - name: "advertising_flag"
        type: "bool"
        range: "true | false"
        origin: "standard"
        description: "Является ли сообщение рекламным."
      - name: "double_optin_flag"
        type: "bool"
        range: "true | false"
        origin: "standard"
        description: "Требуется ли двойное подтверждение."
    international_sources:
      - "BABOK: Business rules / compliance requirements"
      - "Amazon Pinpoint: Consent management (best practice)"
    example_requirements:
      - "Рекламные сообщения должны отправляться только при наличии согласия абонента (TZ 6, 24)."
    related_nfr: ["B10: реклама (38-ФЗ)"]
  - id: "delivery-status-tracking"
    name: "Отслеживание статуса доставки"
    description: "Сбор отчётов о доставке (DLR) и повтор при ошибке."
    parameters:
      - name: "dlr_source"
        type: "enum"
        range: "operator-dlr | aggregator-dlr"
        origin: "standard"
        description: "Источник статуса доставки."
      - name: "status_webhook"
        type: "string"
        range: "URL"
        origin: "standard"
        description: "Точка приёма статусов."
      - name: "retry_policy"
        type: "string"
        range: "число попыток + интервал"
        origin: "standard"
        description: "Повтор при недоставке."
    international_sources:
      - "3GPP TS 23.040: SMS status report"
      - "Amazon Pinpoint: Delivery events"
    example_requirements:
      - "Нужны отчёты о доставке SMS и статистика рассылки (TZ 17, 28)."
    related_nfr: ["B7: отчётность", "B1: доступность доставки"]
```

---

## 🔗 Связь с НФТ-классами

Атомарная функция описывает «что делает продукт». Нефункциональные требования
(НФТ) описывают «насколько хорошо и при каких ограничениях». Их связь — это
**overlay**, а не отдельный домен (см. глоссарий). Классы НФТ берём из
[classification-tz.md](classification-tz.md), §«B. Нефункциональные классы».

### Модель связывания

Каждая функция может иметь поле `related_nfr` со ссылкой на класс НФТ и его
аспект: `B<номер>: <аспект>`. Связь устанавливается по правилу:

```text
Atomic Function ── triggers ──> NFR class (overlay)
   │                               │
   ├─ параметр функции             ├─ задаёт измеримое ограничение/критерий
   └─ пример требования            └─ источник acceptance criteria
```

| Класс НФТ (classification-tz.md) | Типичный триггер на уровне функции | Примеры функций |
| --- | --- | --- |
| B1 SLA / доступность | Функции реального времени и маршрутизации | `queue-overflow-routing`, `operator-fallback-transfer`, `delivery-status-tracking` |
| B2 Производительность / масштабируемость | Параллельная нагрузка, throughput | `predictive-dialing`, `call-recording-capture`, `bulk-sms-dispatch` |
| B3 ИБ / защита ПДн (152-ФЗ) | Доступ к данным, согласие, маскирование | `recording-access-control`, `visitor-data-capture`, `recording-pause-resume` |
| B4 Размещение в РФ / реестр | Где хранятся данные | `recording-retention-policy` |
| B5 Хранение записей и переписок | Параметры `retention_days`, storage | `recording-retention-policy`, `chat-transcript-delivery` |
| B7 Документация поставщика | Экспорт, API, отчётность | `recording-export`, `disposition-code-assignment` |
| B8 Качество ПО / юзабилити | UX-функции, понятность | `ivr-menu-navigation`, `wait-announcement` |
| B9 НПА связи (126-ФЗ и др.) | Номера, отправители, время звонка | `sender-id-management`, `timezone-aware-dialing` |
| B10 Реклама (38-ФЗ) / КИИ (187-ФЗ) | Согласие, отписка, рекламные сообщения | `advertising-consent-check`, `opt-out-handling` |

### Правило для генерации ФТ

Если у функции заполнен `related_nfr`, промпт обязан включить в генерируемое ФТ
не только функциональный параметр, но и измеримый НФТ-критерий. Пример:

```text
Функция: predictive-dialing
Параметр: abandon_rate_limit = 3%
related_nfr: B10 (реклама/abandon), B2 (производительность)
=> ФТ должно содержать:
   - функциональное: "система регулирует темп набора по доступности операторов";
   - НФТ B10: "доля сброшенных вызовов не более 3%";
   - НФТ B2: "поддержка N одновременных исходящих линий" (уточнить с SME).
```

Это связывает «что» (функция) и «насколько» (НФТ) и снижает риск ФТ без
измеримых критериев.

## 🧩 Интеграция с `kb/product-matrix.md`

Справочник — источник для поля `taxonomy_path` и кандидат `keywords` в записях
[`projects/mango/kb/product-matrix.md`](../../projects/mango/kb/product-matrix.md)
(структура записи описана в
[rag-mapping-roadmap-2026-05.md](rag-mapping-roadmap-2026-05.md), §1.2). Здесь —
точка входа для промпта: «сырое требование → нормализация → поиск функции».

### Формат запроса промпта

```yaml
lookup_request:
  raw_requirement: "<сырая формулировка из ТЗ>"
  normalized:
    domain: "<из справочника>"
    capability: "<из справочника>"
    feature: "<из справочника>"
    atomic_function_id: "<id или 'unknown'>"
  expected_output:
    - matched_parameters       # параметры функции из справочника
    - related_nfr              # классы НФТ для acceptance criteria
    - product_matrix_route     # docs_navigation из product-matrix.md
    - coverage_status          # Есть | Частично | Не выявлено | Требует уточнения
    - clarification_questions  # если уверенность низкая
```

### Пример сценария «сырое требование → функция»

```text
1. Вход (сырое требование, TZ 16):
   «Нужна возможность автоматически набирать номера и не терять много звонков
    при недозвоне, чтобы операторы не простаивали.»

2. Нормализация:
   domain: contact-center
   capability: outbound-calling
   feature: campaign-management
   atomic_function_id: predictive-dialing

3. Из справочника:
   parameters: dial_ratio (1.0–5.0), abandon_rate_limit (0–5%), pacing_algorithm
   related_nfr: B2 (производительность), B10 (реклама/abandon)

4. Из product-matrix.md (rag-mapping §1.2):
   taxonomy_path: "CC > outbound-calling > campaign-management"
   docs_navigation: [официальная документация Outbound, API обзвона]

5. Выход (черновик для БА):
   coverage_status: Есть
   ФТ-черновик: "Система регулирует темп предиктивного набора по доступности
                 операторов; доля сброшенных вызовов ≤ 3%."
   clarification_questions:
     - "Какой максимальный dial_ratio допустим для вашей нагрузки?"
     - "Каков целевой лимит abandon_rate (по умолчанию 3%)?"
```

Правило controlled generation (согласовано с rag-mapping §1.3): если
`atomic_function_id = unknown` или все источники имеют низкую уверенность —
промпт не выдумывает покрытие, а возвращает `coverage_status: Требует уточнения`,
предлагает функцию-кандидата для этого справочника и формирует вопросы к BA/SME.

## 🔄 Как обновлять справочник

Процесс добавления/изменения атомарной функции (lightweight, по
[RESEARCH_PROFILE.md](../../standards/RESEARCH_PROFILE.md) и
[ISSUE_WORKFLOW.md](../../standards/ISSUE_WORKFLOW.md)):

| Шаг | Кто | Действие |
| --- | --- | --- |
| 1. Предложение | БА / PO / промпт (как кандидат) | Описать функцию: id, name, проверить по чек-листу §«🔍 Критерии атомарности». |
| 2. Источники | Автор | Добавить ≥2 международных источника и ≥1 пример требования (желательно с TZ #). |
| 3. Параметры | Автор + SME | Заполнить параметры с `origin` (`standard`/`mango-custom`) и диапазонами. |
| 4. НФТ | Автор | Указать `related_nfr`, если функция триггерит НФТ-класс. |
| 5. Ревью | Human reviewer (не автор) | Проверить атомарность, непротиворечивость с `classification.md` и глоссарием. |
| 6. Версионирование | Reviewer | Bump `version` (semver: правка — patch/minor), обновить `updated`, при готовности `status: draft → reviewed`. |
| 7. Регистрация | Reviewer | Если меняется набор capability — синхронизировать с `classification.md` §`Product Layer`. |

Принципы версионирования:

- **Аддитивность**: новые функции добавляются, существующие id не переименовываются (как в `classification.md` v3.0 — 37 строк сохранены).
- **Конфликт источников**: если источники противоречат (например, разные значения по умолчанию), фиксировать 2–3 варианта с плюсами/минусами, не блокируя прогресс.
- **Single source of truth для иерархии**: набор `Domain → Capability → Feature` ведётся в `classification.md`; этот файл детализирует уровень функций.

## 📋 Сводка примеров требований из реальных ТЗ

Явная traceability «функция → реальное требование из корпуса» (см.
[classification-tz.md](classification-tz.md)) для иллюстрации (≥5):

| # | Атомарная функция | Класс ТЗ | Пример требования | TZ # |
| --- | --- | --- | --- | --- |
| 1 | `predictive-dialing` | A7 | «автоматический набор, сброшенных не более 3%» | 1, 16 |
| 2 | `skill-based-routing` | A5 | «распределение вызовов по навыкам (skill-based)» | 3, 16 |
| 3 | `callback` / `queue-overflow-routing` | A5 | «callback по пропущенному / обратный звонок из очереди» | 9, 18 |
| 4 | `recording-retention-policy` | A4 / B5 | «хранение записей не менее 6/12 месяцев, выгрузка на FTP» | 11, 13, 15 |
| 5 | `barge-in` / `whisper-coaching` | A16 | «перехват и режим шёпот для супервизора» | 2, 17 |
| 6 | `timezone-aware-dialing` | A7 | «обзвон с учётом часового пояса абонента» | 8, 17 |
| 7 | `answering-machine-detection` | A8 | «робот отличает человека от автоответчика» | 6, 17 |
| 8 | `opt-out-handling` | A12 / B10 | «возможность отказаться от рассылки» | 19, 26 |
| 9 | `channel-ingestion` | A11 | «единое окно: WhatsApp/Telegram/VK/email» | 4, 16 |
| 10 | `dtmf-input-collection` | A6 | «голосовое меню в тоновом режиме» | 11, 18 |

## ❓ Вопросы для согласования с PO/Founder

1. **Достаточен ли уровень детализации?** Хватает ли 3 capability × 2 feature ×
   3 функции на домен для пилота, или нужны все capability из `classification.md`?
2. **Диапазоны параметров.** Кто и когда подтверждает рабочие диапазоны
   (`status: draft → reviewed`): product SME по каждому домену или единый owner?
3. **`standard` vs `mango-custom`.** Согласен ли PO с правилом «параметр у ≥3
   источников = standard»? Какие `mango-custom`-параметры зафиксировать в `kb/`?
4. **Приоритет расширения.** Какой домен детализировать следующим за пилотом —
   `ai-automation`, `analytics` или кросс-доменные `platform`-возможности?
5. **Связь с НФТ.** Делать ли `related_nfr` обязательным полем при генерации ФТ
   или оставить рекомендательным на время пилота?
6. **Ownership справочника.** Кто owner этого файла: BA lead, Product Operations
   или отдельный PO (как и для taxonomy-концепции)?

## Связанные артефакты

- [research/mango/classification.md](classification.md) — иерархия `Domain → Capability → Feature → Atomic Function` (v3.0), §`📊 Product Layer`.
- [projects/mango/standards/classification-glossary.md](../../projects/mango/standards/classification-glossary.md) — термины уровней и mapping.
- [research/mango/classification-tz.md](classification-tz.md) — корпус ТЗ, классы A/B/C, источник примеров и НФТ.
- [research/mango/rag-mapping-roadmap-2026-05.md](rag-mapping-roadmap-2026-05.md) — структура `kb/product-matrix.md` и интерфейс промпта.
- [research/mango/taxonomy-concept-2026-05.md](taxonomy-concept-2026-05.md) — мета-модель capability и принципы версионирования.
- [standards/RESEARCH_PROFILE.md](../../standards/RESEARCH_PROFILE.md) — правила research-артефактов и цитирования.

## Источники

Международные стандарты и фреймворки:

- TM Forum, Information Framework (SID): <https://www.tmforum.org/open-digital-architecture/information-framework-sid/>
- TM Forum, Open APIs (TMF620, TMF635): <https://www.tmforum.org/oda/open-apis/>
- IIBA, BABOK Guide: <https://www.iiba.org/knowledgehub/business-analysis-body-of-knowledge-babok-guide/>
- IREB, CPRE Glossary: <https://cpre.ireb.org/en/downloads-and-resources/glossary>
- ISO, ISO/IEC 25010:2023 (product quality): <https://www.iso.org/standard/78176.html>
- ISO, ISO/IEC 27001 (information security): <https://www.iso.org/standard/27001>
- ITU-T, Q-series (DTMF signalling Q.23/Q.24): <https://www.itu.int/rec/T-REC-Q/en>
- ITU-T, E.164 (numbering): <https://www.itu.int/rec/T-REC-E.164/en>
- 3GPP, TS 23.040 (SMS / Technical realization): <https://www.3gpp.org/dynareport/23040.htm>
- IETF, RFC 3261 (SIP): <https://www.rfc-editor.org/rfc/rfc3261>
- IETF, RFC 5589 (SIP Call Control – Transfer): <https://www.rfc-editor.org/rfc/rfc5589>

Vendor-документация (как practice-источник, проверять версию на дату использования):

- Genesys Documentation, Outbound Dialing Modes: <https://docs.genesys.com/Documentation/OU/8.1.5/Dep/DialingModes>
- Genesys Documentation (portal): <https://docs.genesys.com/>
- Cisco, Unified Contact Center Enterprise (UCCE) docs: <https://www.cisco.com/c/en/us/support/customer-collaboration/unified-contact-center-enterprise/series.html>
- Amazon Connect, Administrator Guide: <https://docs.aws.amazon.com/connect/latest/adminguide/>
- Amazon Pinpoint, User Guide (SMS): <https://docs.aws.amazon.com/pinpoint/latest/userguide/>

Продукты MANGO OFFICE (для маппинга и evidence):

- MANGO OFFICE, Виртуальная АТС: <https://www.mango-office.ru/products/virtualnaya_ats/>
- MANGO OFFICE, Контакт-центр: <https://www.mango-office.ru/products/contact-center/>
- MANGO OFFICE, документация: <https://docs.mango-office.ru/>
