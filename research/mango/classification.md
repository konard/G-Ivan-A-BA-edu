---
status: reviewed
version: 3.0
updated: 2026-05-27
ai-generated: false
type: external-analysis
context: [mango, product-classification]
method: comparative-analysis
source: research/mango/classification-old.md
---

# Классификация IT/Telecom SaaS-продуктов MANGO OFFICE

Версия: 3.0

Дата среза: 22 мая 2026 г.

Цель документа: зафиксировать рабочую международную и российскую классификацию продуктов и сервисов MANGO OFFICE, чтобы бизнес-аналитик мог сравнивать входящие требования с эталонным каталогом, международными фреймворками, российскими классификаторами, ГОСТ и ключевыми нормативными требованиями для IT/Telecom-операторов.

## Связанные документы

- Термины уровней классификации (Domain, Capability, Feature, Atomic Function) и правила их применения описаны в глоссарии [projects/mango/standards/classification-glossary.md](../../projects/mango/standards/classification-glossary.md). Этот файл — нормализованный продуктовый каталог; единая терминология берётся из глоссария.
- «Зеркало спроса» — корпус из 30 ТЗ и проверка эталона на нём — ведётся отдельно в [classification-tz.md](classification-tz.md). Сырой спрос не интегрируется в этот файл; сюда переносятся только нормализованные продуктовые классы (см. §«Что нового в версии 3.0»).

## Что нового в версии 3.0

Версия 3.0 — аддитивное расширение версии 2: ни одна из 37 существующих строк классификации и ни один существующий раздел не удалены, они только переструктурированы под новую модель и дополнены.

1. Введена иерархия из четырёх уровней `Domain → Capability → Feature → Atomic Function` (см. §«Модель классификации v3.0»).
2. Продуктовые и закупочные атрибуты явно разделены на два слоя: `## 📊 Product Layer` (функциональная иерархия) и `## 🛒 Commercial Layer` (закупочные атрибуты), связанные механизмом `related_commercial_fields`.
3. Добавлены 5 новых `Capability` по итогам анализа корпуса ТЗ (строки 38–42): маркировка номера и «карусельные номера», голосовые SMS, Self-Service портал, мобильное приложение оператора, услуги поддержки и развития CRM/SaaS.
4. Раздел `## 🚀 Возможные улучшения (не активны в v3.0)` фиксирует отложенные атрибуты (R2.6–R2.8) с обоснованием и критериями активации; в основную модель они не входят.
5. Сравнительная таблица международной классификации дополнена колонками `Domain → Capability (v3.0)` и `BABOK`, а также строками 38–42.

## Модель классификации v3.0

Классификация v3.0 описывает продукт в двух ортогональных слоях.

**Product Layer (продуктовый слой)** — функциональная иерархия из четырёх уровней:

| Уровень | Англ. термин | Что описывает | Пример |
| --- | --- | --- | --- |
| 1. Семейство | `Domain` | Крупная продуктовая область | `voice-ucaas` |
| 2. Класс | `Capability` | Группа функций внутри домена | `outbound-calling` |
| 3. Подкласс | `Feature` | Настраиваемая возможность класса | `campaign-management` |
| 4. Функция | `Atomic Function` | Минимальная единица с параметрами | `predictive-dialing` (params: dial_ratio, abandon_rate_limit) |

Пилот покрывает семь доменов: `voice-ucaas`, `contact-center`, `digital-channels`, `ai-automation`, `analytics`, `hardware`, `security`. Возможности, не привязанные к одному домену (интеграции, API, CPaaS, service desk, vendor-услуги), вынесены в отдельный блок «Кросс-доменные возможности (platform)».

**Commercial Layer (закупочный слой)** — атрибуты, описывающие не функцию, а условия закупки, лицензирования и поставки (тариф, срок договора, лицензионная модель, формат закупки, сертификаты/реестры, квалификация поставщика, конфиденциальность). Эти атрибуты не входят в продуктовую иерархию.

**Механизм связывания.** Каждая `Capability` в Product Layer содержит поле `related_commercial_fields` — список идентификаторов закупочных полей из Commercial Layer, которые обычно сопровождают требования к этому классу. Обратное соответствие (закупочное поле → классы) приведено в §«🛒 Commercial Layer». Так одно требование получает и продуктовый ключ (`Domain → Capability → Feature → Atomic Function`), и закупочный контекст, не смешивая «что делает продукт» и «на каких условиях он закупается».

Все внутренние идентификаторы уровней и полей записываются в `lowercase-with-hyphens`; имена параметров атомарных функций — в `snake_case`. В колонке `Mango status` сохраняются значения версии 2: **Есть**, **Частично**, **Не выявлено**, **Вне SaaS-ядра**. Поле `row` ссылается на номер строки в §«Сравнительная таблица международной классификации».

## Краткий вывод

Публичный каталог MANGO OFFICE покрывает пять крупных продуктовых семейств:

1. Корпоративная телефония и UCaaS: виртуальная АТС, IP-телефония, номера, SIP trunk, мобильная телефония, запись, IVR, распределение звонков, Mango Talker и видеоконференции.
2. Контакт-центр и CCaaS: входящие и исходящие обращения, омниканальность, рабочее место оператора, отчеты, WFM, управление персоналом, база знаний, чат для сайта, управление сделками и оценка эффективности.
3. Цифровые каналы и коммуникации: онлайн-чат, мессенджеры, email, SMS, мессенджер-маркетинг, единое окно оператора.
4. AI и автоматизация: голосовой робот, чат-бот, робот-администратор, речевая аналитика, управление качеством, робот-аналитик и робот-маркетолог.
5. Маркетинговая и бизнес-аналитика: коллтрекинг, мультиканальная и сквозная аналитика, email-трекинг, ROMI, товарная аналитика, анализ конкурентов и интеграции с CRM/1C/API/webhook.

Для международной классификации выбраны два взаимодополняющих фреймворка:

- **TM Forum Frameworx / Open APIs**: основной отраслевой фреймворк для телеком- и цифровых сервис-провайдеров. Он удобен для внутренней классификации требований через домены Market & Sales, Customer, Product, Service и Resource, а также через жизненный цикл каталога, заказа, обслуживания и эксплуатации.
- **UNSPSC**: глобальная товарно-сервисная классификация ООН/UNDP. Она удобна для закупочной, договорной и внешней классификации: к каждому продукту можно присвоить код commodity-класса и связать требование с международной номенклатурой.

Версия 2 добавила российский слой классификации:

- **ОКПД 2 / ОКВЭД 2**: российская закупочная и статистическая классификация. Для продуктовых требований основным является ОКПД 2; ОКВЭД 2 полезен только для описания вида деятельности поставщика или оператора.
- **ГОСТ и национальные стандарты РФ**: телеком-качество, call-center service quality, ITSM, облачные вычисления, безопасность, персональные данные, AI и качество ПО.
- **Нормативные правовые акты РФ**: применяются не как классификатор продукта, а как compliance-слой для требований к связи, передаче данных, телематическим услугам, персональным данным, рекламе и КИИ.

Рекомендуемая схема для БА: одно требование получает четыре ключа классификации. Первый ключ отвечает на вопрос "какой это продукт MANGO OFFICE"; второй - "какой это домен и capability в телеком/цифровом сервис-провайдере" по TM Forum; третий - "какой это товарно-сервисный класс" по UNSPSC/ОКПД 2; четвертый - "какие российские ГОСТ/НПА нужно учитывать в описании требований, SLA, безопасности и договора". В версии 3.0 к продуктовым ключам добавляется закупочный слой (см. §«🛒 Commercial Layer»).

## Методика

- Источники по продуктам: публичный каталог и страницы продуктов MANGO OFFICE на `mango-office.ru`.
- Источники по международным стандартам: страницы TM Forum по eTOM, SID и TMF620; официальный обзор UNSPSC от UNDP; публичный экспорт UNSPSC из UNGM; свод знаний BABOK Guide v3 от IIBA для бизнес-аналитической перспективы.
- Источники по российскому слою: национальные стандарты РФ и межгосударственные ГОСТ в области связи, облачных вычислений, ITSM, ИБ, AI, качества ПО и центров обработки вызовов; ОКПД 2/ОКВЭД 2; федеральные законы и постановления Правительства РФ, применимые к услугам связи, передаче данных, телематическим услугам, персональным данным, рекламе и КИИ.
- Статус в колонке MANGO OFFICE:
  - **Есть**: продукт или возможность явно присутствует в публичном каталоге.
  - **Частично**: возможность есть как часть более крупного продукта, через модуль, интеграцию или ограниченный сценарий.
  - **Не выявлено**: в публичном каталоге не найден самостоятельный продукт такого класса.
  - **Вне SaaS-ядра**: предложение присутствует, но относится к оборудованию или смежной поставке, а не к SaaS-сервису.
- UNSPSC-коды приведены как рабочие коды для классификации требований. Для закупки или договора их стоит проверять по актуальному экспортному файлу UNGM/UNSPSC на дату использования.
- ОКПД 2-коды в версии 2 указаны на уровне классов и подклассов, достаточном для аналитической классификации. Для закупки, договора или бухгалтерского применения код нужно уточнять по актуальной редакции ОК 034-2014.
- ГОСТ и НПА в версии 2 не заменяют юридическую экспертизу. Национальные стандарты обычно применяются добровольно, если их не сделали обязательными договор, техническое задание, отраслевой регламент или ссылка в нормативном акте.

## 📊 Product Layer

Функциональная иерархия `Domain → Capability → Feature → Atomic Function`. Каждый класс снабжён полем `related_commercial_fields` (связь с §«🛒 Commercial Layer»), значением `Mango status` и ссылкой `row` на строку сравнительной таблицы. Это структурированное представление тех же 37 продуктов из версии 2 плюс 5 новых классов (строки 38–42).

### 📦 Domain: voice-ucaas

**Name**: Телефония и унифицированные коммуникации

#### 🔹 Capability: cloud-pbx (Виртуальная / облачная АТС)
- **Features**: extension-management, call-routing-rules, working-hours-schedule, voicemail
- **Atomic Functions**:
  - `extension-provisioning` (params: extension_range, sip_profile)
  - `auto-attendant` (params: greeting_set, routing_tree)
  - `working-hours-routing` (params: schedule_id, holiday_calendar)
  - `voicemail-to-email` (params: mailbox_id, delivery_format)
- **related_commercial_fields**: tariff-model, license-model, procurement-format
- **Mango status**: Есть · **row**: 1

#### 🔹 Capability: sip-connectivity (IP-телефония и SIP trunk)
- **Features**: sip-trunking, codec-negotiation, failover-routing
- **Atomic Functions**:
  - `sip-trunk-registration` (params: trunk_id, auth_credentials)
  - `codec-selection` (params: codec_priority, dtmf_mode)
  - `trunk-failover` (params: backup_trunk_id, retry_interval)
- **related_commercial_fields**: tariff-model, contract-duration
- **Mango status**: Есть · **row**: 2

#### 🔹 Capability: number-management (Номерная ёмкость)
- **Features**: virtual-numbers, toll-free-8800, mobile-numbers, number-porting
- **Atomic Functions**:
  - `number-assignment` (params: number_type, region_code)
  - `number-porting` (params: donor_operator, port_window)
  - `tollfree-routing` (params: number_8800, destination_map)
- **related_commercial_fields**: tariff-model, certification-registry
- **Mango status**: Есть · **row**: 3

#### 🔹 Capability: ivr-voice-menu (Голосовое меню IVR и автоинформирование)
- **Features**: ivr-scenarios, auto-secretary, voice-announcement
- **Atomic Functions**:
  - `ivr-menu-navigation` (params: menu_tree, timeout_action)
  - `auto-secretary-greeting` (params: greeting_id, dtmf_map)
  - `service-availability-routing` (params: queue_id, overflow_target)
- **related_commercial_fields**: tariff-model, license-model
- **Mango status**: Есть · **row**: 4

#### 🔹 Capability: call-recording (Запись разговоров и журналирование)
- **Features**: call-recording, call-log, usage-statistics
- **Atomic Functions**:
  - `call-recording-capture` (params: retention_period, storage_target)
  - `call-log-export` (params: date_range, export_format)
  - `recording-access-control` (params: role_id, masking_policy)
- **related_commercial_fields**: confidentiality-terms, certification-registry
- **Mango status**: Есть · **row**: 6

#### 🔹 Capability: callback (Обратный звонок с сайта)
- **Features**: web-callback-widget, consent-capture, callback-scheduling
- **Atomic Functions**:
  - `callback-request-intake` (params: widget_id, consent_flag)
  - `callback-scheduling` (params: max_attempts, time_window)
- **related_commercial_fields**: tariff-model, confidentiality-terms
- **Mango status**: Есть · **row**: 7

#### 🔹 Capability: unified-communications (Корпоративный мессенджер и softphone — Mango Talker)
- **Features**: softphone, corporate-messaging, presence-status
- **Atomic Functions**:
  - `softphone-call` (params: device_id, sip_account)
  - `corporate-chat` (params: channel_id, retention_period)
  - `presence-update` (params: status_code, visibility_scope)
- **related_commercial_fields**: license-model, tariff-model
- **Mango status**: Есть · **row**: 8

#### 🔹 Capability: video-conferencing (Видеоконференции)
- **Features**: video-meetings, meeting-recording, screen-sharing
- **Atomic Functions**:
  - `meeting-host` (params: max_participants, meeting_id)
  - `meeting-recording` (params: retention_period, consent_flag)
  - `screen-share` (params: session_id, quality_profile)
- **related_commercial_fields**: license-model, tariff-model
- **Mango status**: Есть · **row**: 9

#### 🔹 Capability: number-branding (Маркировка номера, «карусельные номера», защита дозваниваемости) — R2.1, новый
- **Features**: number-labeling, carousel-numbers, reachability-protection, anti-spam-marking
- **Atomic Functions**:
  - `caller-id-labeling` (params: brand_label, aggregator_id)
  - `carousel-number-rotation` (params: number_pool, rotation_policy)
  - `reachability-monitoring` (params: spam_score_threshold, alert_channel)
- **related_commercial_fields**: tariff-model, certification-registry, procurement-format
- **Mango status**: Не выявлено · **row**: 38

#### 🔹 Capability: voice-sms-broadcast (Голосовые SMS / автоинформирование через голосовой канал) — R2.2, новый
- **Features**: voice-broadcast, auto-notification, delivery-confirmation
- **Atomic Functions**:
  - `voice-message-broadcast` (params: contact_list, voice_template)
  - `delivery-confirmation` (params: dtmf_confirm, retry_policy)
  - `consent-filter` (params: opt_in_list, advertising_flag)
- **related_commercial_fields**: tariff-model, confidentiality-terms
- **Mango status**: Частично · **row**: 39

### 📦 Domain: contact-center

**Name**: Контакт-центр и CCaaS

#### 🔹 Capability: call-routing (Распределение звонков, очереди, маршрутизация)
- **Features**: skill-based-routing, queue-management, overflow-rules
- **Atomic Functions**:
  - `skill-based-routing` (params: skill_group, priority_weight)
  - `queue-management` (params: max_wait_time, sla_threshold)
  - `overflow-routing` (params: overflow_target, abandon_threshold)
- **related_commercial_fields**: tariff-model, license-model
- **Mango status**: Есть · **row**: 5

#### 🔹 Capability: omnichannel-contact-center (Омниканальный контакт-центр / CCaaS)
- **Features**: inbound-handling, omnichannel-desktop, channel-blending
- **Atomic Functions**:
  - `interaction-routing` (params: channel_type, routing_profile)
  - `unified-agent-desktop` (params: layout_id, channel_set)
- **related_commercial_fields**: tariff-model, license-model, procurement-format
- **Mango status**: Есть · **row**: 11

#### 🔹 Capability: agent-workspace (Входящие обращения и рабочее место оператора)
- **Features**: agent-desktop, customer-card, interaction-history
- **Atomic Functions**:
  - `interaction-handling` (params: interaction_id, disposition_code)
  - `customer-card-popup` (params: crm_lookup_key, screen_pop_layout)
- **related_commercial_fields**: license-model, confidentiality-terms
- **Mango status**: Есть · **row**: 12

#### 🔹 Capability: outbound-calling (Исходящий обзвон и кампании)
- **Features**: campaign-management, dialing-modes, realtime-analytics, historical-reports
- **Atomic Functions**:
  - `predictive-dialing` (params: dial_ratio, abandon_rate_limit)
  - `callback-scheduling` (params: max_attempts, time_window)
  - `disposition-code-assignment` (params: code_list, auto_tagging)
- **related_commercial_fields**: tariff-model, procurement-format
- **Mango status**: Есть · **row**: 13

#### 🔹 Capability: quality-management (Управление качеством операторов / QM)
- **Features**: scorecards, call-sampling, evaluation-workflow
- **Atomic Functions**:
  - `scorecard-evaluation` (params: checklist_id, sampling_rate)
  - `evaluation-appeal` (params: case_id, reviewer_role)
- **related_commercial_fields**: license-model
- **Mango status**: Есть · **row**: 20

#### 🔹 Capability: workforce-management (WFM / управление рабочими ресурсами)
- **Features**: shift-scheduling, load-forecasting, adherence-tracking
- **Atomic Functions**:
  - `load-forecasting` (params: history_window, forecast_horizon)
  - `shift-scheduling` (params: agent_pool, coverage_target)
- **related_commercial_fields**: license-model, confidentiality-terms
- **Mango status**: Есть · **row**: 21

#### 🔹 Capability: knowledge-base (База знаний и скрипты операторов)
- **Features**: knowledge-articles, agent-scripts, version-control
- **Atomic Functions**:
  - `article-lifecycle` (params: article_id, review_status)
  - `script-guidance` (params: scenario_id, branching_rules)
- **related_commercial_fields**: license-model
- **Mango status**: Есть · **row**: 22

#### 🔹 Capability: deal-management (Управление сделками / лёгкий CRM-сценарий)
- **Features**: deal-pipeline, contact-management, communication-history
- **Atomic Functions**:
  - `deal-pipeline-tracking` (params: pipeline_id, stage_map)
  - `communication-logging` (params: contact_id, channel_type)
- **related_commercial_fields**: license-model, confidentiality-terms
- **Mango status**: Есть · **row**: 23

#### 🔹 Capability: crm-platform (Полноценная CRM как самостоятельная платформа)
- **Features**: crm-core, sales-automation
- **Atomic Functions**:
  - `crm-record-management` (params: entity_type, field_schema)
- **related_commercial_fields**: license-model, contract-duration
- **Mango status**: Частично · **row**: 24

#### 🔹 Capability: self-service-portal (Self-Service портал клиента / личный кабинет заказчика) — R2.3, новый
- **Features**: customer-portal, self-onboarding, recording-access, service-catalog-selection
- **Atomic Functions**:
  - `self-service-login` (params: account_id, auth_method)
  - `service-self-provisioning` (params: catalog_item, approval_flow)
  - `self-service-recording-access` (params: masking_policy, retention_period)
- **related_commercial_fields**: license-model, confidentiality-terms, certification-registry
- **Mango status**: Частично · **row**: 40

#### 🔹 Capability: operator-mobile-app (Мобильное приложение оператора CCaaS) — R2.4, новый
- **Features**: mobile-agent-desktop, push-notifications, offline-mode
- **Atomic Functions**:
  - `mobile-interaction-handling` (params: device_id, channel_set)
  - `push-notification-delivery` (params: notification_type, priority)
- **related_commercial_fields**: license-model, tariff-model
- **Mango status**: Частично · **row**: 41

### 📦 Domain: digital-channels

**Name**: Цифровые каналы и коммуникации

#### 🔹 Capability: sms-messaging (SMS-рассылки)
- **Features**: bulk-sms, transactional-sms, opt-out-management
- **Atomic Functions**:
  - `bulk-sms-dispatch` (params: contact_list, message_template)
  - `opt-out-handling` (params: stop_keyword, suppression_list)
  - `advertising-consent-check` (params: consent_source, advertising_flag)
- **related_commercial_fields**: tariff-model, confidentiality-terms
- **Mango status**: Есть · **row**: 10

#### 🔹 Capability: omnichannel-messaging (Омниканальные коммуникации: чат, мессенджеры, соцсети, email)
- **Features**: messenger-integration, social-channels, email-channel, unified-inbox
- **Atomic Functions**:
  - `channel-ingestion` (params: channel_type, account_credentials)
  - `unified-inbox-routing` (params: inbox_id, routing_rules)
- **related_commercial_fields**: tariff-model, license-model
- **Mango status**: Есть · **row**: 14

#### 🔹 Capability: website-chat (Чат для сайта)
- **Features**: chat-widget, proactive-invitations, visitor-tracking
- **Atomic Functions**:
  - `chat-widget-embed` (params: widget_id, trigger_rules)
  - `visitor-data-capture` (params: consent_flag, field_set)
- **related_commercial_fields**: license-model, confidentiality-terms
- **Mango status**: Есть · **row**: 15

#### 🔹 Capability: messenger-marketing (Мессенджер-маркетинг)
- **Features**: campaign-templates, broadcast-lists, opt-in-management
- **Atomic Functions**:
  - `messenger-campaign-dispatch` (params: template_id, audience_segment)
  - `messenger-optin-management` (params: optin_source, suppression_list)
- **related_commercial_fields**: tariff-model, confidentiality-terms
- **Mango status**: Есть · **row**: 33

### 📦 Domain: ai-automation

**Name**: AI и автоматизация

#### 🔹 Capability: chatbot (Чат-бот)
- **Features**: dialog-scenarios, intent-recognition, agent-handoff
- **Atomic Functions**:
  - `intent-classification` (params: model_id, confidence_threshold)
  - `agent-handoff` (params: fallback_queue, context_payload)
- **related_commercial_fields**: license-model, certification-registry
- **Mango status**: Есть · **row**: 16

#### 🔹 Capability: voice-bot (Голосовой робот / voice bot)
- **Features**: speech-recognition, dialog-orchestration, tts-synthesis
- **Atomic Functions**:
  - `speech-to-text` (params: language_model, confidence_threshold)
  - `voice-dialog-flow` (params: scenario_id, fallback_action)
  - `text-to-speech` (params: voice_profile, prosody_settings)
- **related_commercial_fields**: license-model, certification-registry
- **Mango status**: Есть · **row**: 17

#### 🔹 Capability: process-robot (Робот-администратор)
- **Features**: process-automation, action-orchestration, audit-logging
- **Atomic Functions**:
  - `automated-action-execution` (params: process_id, permission_scope)
  - `action-audit-logging` (params: log_target, event_filter)
- **related_commercial_fields**: license-model
- **Mango status**: Есть · **row**: 18

#### 🔹 Capability: speech-analytics (Речевая аналитика / conversation intelligence)
- **Features**: transcription, sentiment-analysis, keyword-detection
- **Atomic Functions**:
  - `call-transcription` (params: language_model, diarization_flag)
  - `keyword-spotting` (params: keyword_set, alert_rule)
  - `sentiment-scoring` (params: model_id, score_scale)
- **related_commercial_fields**: license-model, confidentiality-terms
- **Mango status**: Есть · **row**: 19

### 📦 Domain: analytics

**Name**: Маркетинговая и бизнес-аналитика

#### 🔹 Capability: call-tracking (Коллтрекинг)
- **Features**: dynamic-number-pool, source-attribution, call-analytics
- **Atomic Functions**:
  - `dynamic-number-substitution` (params: number_pool, session_ttl)
  - `source-attribution` (params: utm_map, attribution_window)
- **related_commercial_fields**: tariff-model, confidentiality-terms
- **Mango status**: Есть · **row**: 27

#### 🔹 Capability: end-to-end-analytics (Сквозная аналитика и ROMI)
- **Features**: revenue-attribution, romi-calculation, funnel-analysis
- **Atomic Functions**:
  - `romi-calculation` (params: cost_source, revenue_source)
  - `funnel-tracking` (params: stage_map, conversion_window)
- **related_commercial_fields**: license-model, confidentiality-terms
- **Mango status**: Есть · **row**: 28

#### 🔹 Capability: multichannel-analytics (Мультиканальная аналитика и атрибуция)
- **Features**: channel-attribution, deduplication, conversion-tracking
- **Atomic Functions**:
  - `attribution-modeling` (params: model_type, lookback_window)
  - `lead-deduplication` (params: match_keys, merge_policy)
- **related_commercial_fields**: license-model
- **Mango status**: Есть · **row**: 29

#### 🔹 Capability: email-tracking (Email-трекинг)
- **Features**: open-tracking, click-tracking, unsubscribe-management
- **Atomic Functions**:
  - `email-event-tracking` (params: tracking_pixel, event_type)
  - `unsubscribe-handling` (params: list_id, suppression_policy)
- **related_commercial_fields**: license-model, confidentiality-terms
- **Mango status**: Есть · **row**: 30

#### 🔹 Capability: product-analytics (Товарная аналитика / ecommerce analytics)
- **Features**: demand-analysis, sku-performance, data-quality
- **Atomic Functions**:
  - `sku-performance-analysis` (params: catalog_source, metric_set)
  - `data-quality-check` (params: quality_rules, threshold)
- **related_commercial_fields**: license-model
- **Mango status**: Есть · **row**: 31

#### 🔹 Capability: competitor-analysis (Анализ конкурентов)
- **Features**: market-monitoring, benchmark-reports
- **Atomic Functions**:
  - `competitor-data-collection` (params: source_list, refresh_interval)
- **related_commercial_fields**: license-model
- **Mango status**: Есть · **row**: 32

### 📦 Domain: hardware

**Name**: Оборудование

#### 🔹 Capability: telephony-equipment (SIP-телефоны, гарнитуры и устройства)
- **Features**: sip-phones, headsets, accessories
- **Atomic Functions**:
  - `device-provisioning` (params: device_model, firmware_version)
  - `device-compatibility-check` (params: sip_profile, certification_id)
- **related_commercial_fields**: procurement-format, certification-registry, contract-duration
- **Mango status**: Вне SaaS-ядра · **row**: 37

### 📦 Domain: security

**Name**: Безопасность и доверие

#### 🔹 Capability: information-security (Информационная безопасность)
- **Features**: access-control, audit-logging, data-classification, incident-management
- **Atomic Functions**:
  - `role-based-access-control` (params: role_id, permission_scope)
  - `security-audit-logging` (params: log_target, retention_period)
  - `data-classification` (params: sensitivity_label, handling_policy)
- **related_commercial_fields**: certification-registry, confidentiality-terms
- **Mango status**: Есть (сквозной слой) · **row**: 36

### 🧩 Кросс-доменные возможности (platform)

Классы, не привязанные к одному домену: интеграционная платформа и vendor-услуги поддерживают все семь доменов.

#### 🔹 Capability: platform-integration (Интеграции с CRM, 1C, LDAP, marketplace)
- **Features**: crm-connectors, erp-connectors, directory-sync, marketplace-apps
- **Atomic Functions**:
  - `crm-bidirectional-sync` (params: connector_id, sync_interval)
  - `directory-sync` (params: ldap_endpoint, attribute_map)
- **related_commercial_fields**: license-model, confidentiality-terms
- **Mango status**: Есть · **row**: 25

#### 🔹 Capability: open-api (Open API, webhook, API для УВК/CRM)
- **Features**: rest-api, webhooks, event-streaming
- **Atomic Functions**:
  - `webhook-subscription` (params: event_type, callback_url)
  - `api-rate-limiting` (params: rate_limit, quota_window)
- **related_commercial_fields**: license-model, certification-registry
- **Mango status**: Есть · **row**: 26

#### 🔹 Capability: cpaas (CPaaS / программируемые голосовые и messaging API)
- **Features**: programmable-voice, programmable-messaging, number-api
- **Atomic Functions**:
  - `programmable-voice-call` (params: from_number, callflow_id)
  - `programmable-message-send` (params: channel_type, message_payload)
- **related_commercial_fields**: tariff-model, license-model
- **Mango status**: Частично · **row**: 34

#### 🔹 Capability: service-desk (Service desk / ITSM helpdesk)
- **Features**: ticketing, incident-management, request-fulfilment
- **Atomic Functions**:
  - `ticket-lifecycle` (params: ticket_type, sla_policy)
- **related_commercial_fields**: license-model, contract-duration
- **Mango status**: Частично · **row**: 35

#### 🔹 Capability: vendor-support-services (Услуги поддержки и развития CRM/SaaS как vendor-service) — R2.5, новый
- **Features**: application-maintenance, crm-development, professional-services
- **Atomic Functions**:
  - `application-maintenance` (params: sla_tier, support_window)
  - `crm-customization` (params: scope_spec, change_request_id)
- **related_commercial_fields**: contract-duration, license-model, procurement-format, certification-registry
- **Mango status**: Не выявлено · **row**: 42

## 🛒 Commercial Layer

Закупочный слой описывает условия закупки, лицензирования и поставки, а не функцию продукта. Эти поля **не входят** в продуктовую иерархию Product Layer, но связаны с её классами через `related_commercial_fields`. Каталог полей нормализует коммерческо-договорные классы C1–C7 и предложенные в `classification-tz.md` (R3) закупочные поля.

### Каталог закупочных полей

| Поле (id) | Назначение | Примеры значений | Исток в `classification-tz.md` |
| --- | --- | --- | --- |
| `tariff-model` | Тарифная модель и порядок оплаты | минута / абонплата / постоплата 60 кд / mixed | C1; R3 `Commercial model` |
| `contract-duration` | Срок договора, пролонгация, расторжение | 12 мес / 24 мес / 36 мес / бессрочно | C2; R3 `Contract duration` |
| `license-model` | Лицензионная и поставочная модель ПО | SaaS-подписка / неисключительная лицензия / OEM / доработка ПО | C3; R3 `License model` |
| `procurement-format` | Формат закупочной процедуры | прямой договор / RFI / RFP / single-lot / multi-lot (Лот 1..N) | C6; R3 `Procurement format` |
| `certification-registry` | Сертификаты, лицензии, реестры | лицензия связи / реестр российского ПО (Минцифры) / ISO 27001 / ФСТЭК | C4 |
| `vendor-qualification` | Опыт, кейсы, референсы поставщика | реализованные проекты / референс-визиты / отраслевые кейсы | C5 |
| `confidentiality-terms` | Конфиденциальность, NDA, ответственность сторон | NDA / коммерческая тайна / ответственность за инциденты | C7 |

### Связь Commercial Layer → Product Layer

Обратное соответствие закупочного поля и продуктовых классов, которые на него ссылаются в `related_commercial_fields`.

| Закупочное поле | Связанные Capability (Product Layer) |
| --- | --- |
| `tariff-model` | cloud-pbx, sip-connectivity, number-management, ivr-voice-menu, callback, unified-communications, video-conferencing, number-branding, voice-sms-broadcast, call-routing, omnichannel-contact-center, outbound-calling, operator-mobile-app, sms-messaging, omnichannel-messaging, messenger-marketing, call-tracking, cpaas |
| `contract-duration` | sip-connectivity, crm-platform, telephony-equipment, service-desk, vendor-support-services |
| `license-model` | cloud-pbx, ivr-voice-menu, unified-communications, video-conferencing, call-routing, omnichannel-contact-center, agent-workspace, quality-management, workforce-management, knowledge-base, deal-management, crm-platform, self-service-portal, operator-mobile-app, omnichannel-messaging, website-chat, chatbot, voice-bot, process-robot, speech-analytics, end-to-end-analytics, multichannel-analytics, email-tracking, product-analytics, competitor-analysis, platform-integration, open-api, cpaas, service-desk, vendor-support-services |
| `procurement-format` | cloud-pbx, number-branding, omnichannel-contact-center, outbound-calling, telephony-equipment, vendor-support-services |
| `certification-registry` | number-management, call-recording, number-branding, self-service-portal, chatbot, voice-bot, open-api, telephony-equipment, information-security, vendor-support-services |
| `vendor-qualification` | применяется к любому требованию на уровне закупочной квалификации поставщика (не привязано к одному классу) |
| `confidentiality-terms` | call-recording, callback, voice-sms-broadcast, agent-workspace, workforce-management, deal-management, self-service-portal, sms-messaging, website-chat, messenger-marketing, speech-analytics, call-tracking, end-to-end-analytics, email-tracking, platform-integration, information-security |

Практическое правило: продуктовый ключ (`Domain → Capability → Feature → Atomic Function`) и закупочный ключ заполняются независимо. Если требование описывает только коммерческие условия (например, закупочная процедура без функциональных требований), оно получает значения Commercial Layer без обязательной привязки к Capability — это явный сигнал «сравнивать только на закупочном уровне».

## Анализ публичного каталога MANGO OFFICE

| Семейство | Продукты и возможности MANGO OFFICE | Роль в классификации требований |
| --- | --- | --- |
| Телефония и UCaaS | Виртуальная АТС, IP-телефония, виртуальные номера, 8-800, SIP trunk, запись разговоров, голосовое меню IVR, распределение звонков, автосекретарь, обратный звонок, SMS-рассылки, Mango Mobile, Mango Talker, видеоконференции | Базовый класс требований к корпоративной голосовой связи, унифицированным коммуникациям и номерной емкости |
| Контакт-центр и CCaaS | Омниканальный контакт-центр, исходящий обзвон, омниканальные коммуникации, рабочее место сотрудника, управление персоналом, WFM, конструктор отчетов, робот-администратор, база знаний, чат для сайта, управление сделками, оценка эффективности, API для УВК/CRM | Класс требований к обслуживанию клиентов, очередям, маршрутизации, outbound-кампаниям, SLA и рабочему месту оператора |
| Интеграции | Интеграции по API, webhook, 1C, LDAP/ОПДкРК, маркетплейс интеграций | Класс требований к обмену данными, embedding в CRM/ERP, событиям, синхронизации справочников и расширяемости |
| AI и контроль качества | Голосовой робот, чат-бот, искусственный интеллект, речевая аналитика, управление качеством, бизнес-аналитика | Класс требований к автоматизации диалогов, распознаванию речи, контролю качества, аналитике операторов и снижению ручной нагрузки |
| Маркетинговая аналитика | Коллтрекинг, мультиканальная аналитика, сквозная аналитика, email-трекинг, ROMI, товарная аналитика, анализ конкурентов, робот-аналитик, робот-маркетолог, мессенджер-маркетинг | Класс требований к атрибуции, источникам лидов, рекламной эффективности и маркетинговым отчетам |
| Оборудование и безопасность | SIP-телефоны, гарнитуры, устройства, информационная безопасность | Смежные классы: оборудование и защищенность сервиса. Не являются ядром SaaS-классификации, но важны для полного требования |

## Рассмотренные стандарты и фреймворки

| Стандарт или фреймворк | Что дает для этой задачи | Решение |
| --- | --- | --- |
| TM Forum Frameworx: eTOM, SID, Open APIs | Отраслевой язык телеком-провайдера: продукт, сервис, ресурс, клиент, заказ, каталог, эксплуатация, партнеры. Хорошо подходит для MANGO OFFICE как поставщика коммуникационных сервисов. | Выбран как основной доменный стандарт |
| UNSPSC | Международная иерархическая классификация продуктов и услуг. Хорошо подходит для внешнего сравнения, закупки и кодирования требований. | Выбран как второй стандарт |
| BABOK Guide v3 (IIBA) | Свод знаний по бизнес-анализу: области знаний (Strategy Analysis, Requirements Analysis and Design Definition, Solution Evaluation) и техники (Process Modelling, Interface Analysis, Non-Functional Requirements Analysis, Decision Modelling, Metrics and KPIs, Vendor Assessment). Не классифицирует продукт, но указывает, какой аналитической техникой эффективнее всего выявлять и анализировать требование к данному классу. | Добавлен в версию 3.0 как бизнес-аналитическая перспектива в сравнительной таблице |
| ОКПД 2 / ОКВЭД 2 | Российские классификаторы продукции, услуг и видов деятельности. ОКПД 2 применим к закупкам и договорам, ОКВЭД 2 - к описанию деятельности поставщика. | Добавлен в версию 2 как российский классификационный слой |
| ГОСТ и национальные стандарты РФ | Дают терминологию, показатели качества, сервисные процессы, требования к облакам, ИБ, AI, качеству ПО и контакт-центрам. | Добавлены в версию 2 как слой соответствия и документации |
| Российские НПА для связи, данных, рекламы, ПДн и КИИ | Не являются товарной классификацией, но задают обязательный контекст для оператора связи и SaaS-сервисов, обрабатывающих клиентские данные. | Добавлены в версию 2 как compliance-слой |
| ITIL 4 / ISO/IEC 20000 | Сильный фреймворк управления IT-сервисами: SLA, инциденты, запросы, каталог услуг, эксплуатация. Полезен для NFR и процессов поддержки, но слабее классифицирует сами телеком/SaaS-продукты. | Не выбран для международной продуктовой таблицы, использовать как дополнительный процессный слой |
| MEF LSO | Полезен для операторских сетевых сервисов и оркестрации connectivity/NaaS. Для ВАТС, контакт-центра, ботов и маркетинговой аналитики слишком узкий. | Не выбран для основной таблицы |
| NAICS/ISIC/ОКВЭД-подобные классификаторы | Классифицируют отрасли и компании, а не конкретные SaaS-продукты. | Не выбран |

## Российские стандарты и нормативные источники

| Группа | Документы | Где применять в классификации MANGO OFFICE |
| --- | --- | --- |
| Российские классификаторы | ОКПД 2: раздел J, классы 61 "Услуги телекоммуникационные", 62.0 "Продукты программные и услуги по разработке программного обеспечения", 63.11 "Услуги по обработке данных, размещению и взаимосвязанные услуги"; ОКВЭД 2: раздел J, классы 61, 62, 63 | Для закупочной и договорной привязки продукта. ОКПД 2 выбирать по предмету поставки; ОКВЭД 2 не подменяет продуктовый код, но полезен в описании деятельности поставщика |
| Базовые НПА связи | Федеральный закон N 126-ФЗ "О связи"; Постановление Правительства РФ N 1994 "Об утверждении Правил оказания услуг телефонной связи"; Постановление Правительства РФ N 2606 "Об утверждении Правил оказания услуг связи по передаче данных"; Постановление Правительства РФ N 2607 "Об утверждении Правил оказания телематических услуг связи" | Для телефонии, SIP, номеров, SMS, CPaaS/API-коммуникаций, передачи данных и телематических сервисов. В требованиях фиксировать тип услуги связи, договорные условия, тарификацию, доступность, идентификацию пользователя и границы ответственности |
| Качество услуг связи | ГОСТ Р 53724-2009 "Качество услуг связи. Общие положения"; ГОСТ Р 53731-2009 "Качество услуг связи. Термины и определения"; ГОСТ Р 53532-2009 "Качество услуг связи. Показатели качества услуг телефонной связи в сети общего пользования. Общие требования"; ГОСТ Р 53728-2009 "Качество услуги 'Передача данных'. Показатели качества"; ГОСТ Р 56087.3-2014 "Нормативные значения показателей качества услуг связи на этапах взаимодействия с потребителем" | Для SLA, доступности, сроков подключения и восстановления, качества обслуживания, обработки обращений и показателей "из конца в конец" |
| Контакт-центр | ГОСТ Р 55540-2013 "Качество услуги 'Услуга центра обработки вызовов'. Показатели качества" | Для CCaaS, входящих/исходящих обращений, IVR, очередей, рабочего места оператора, контроля качества и WFM |
| Облачные и SaaS-сервисы | ГОСТ ISO/IEC 17788-2016 "Облачные вычисления. Общие положения и терминология"; ГОСТ Р 70860-2023 "Облачные вычисления. Общие технологии и методы"; ГОСТ Р ИСО/МЭК 27017-2021 по ИБ облачных служб; ГОСТ Р ИСО/МЭК 27018-2020 по защите ПДн в публичных облаках | Для SaaS-описания ВАТС, контакт-центра, аналитики, ботов, интеграций и видеоконференций: модель облачной услуги, роли поставщика/потребителя, границы ответственности, переносимость, ИБ и ПДн |
| ITSM и эксплуатация сервиса | ГОСТ Р ИСО/МЭК 20000-1-2021 "Менеджмент сервисов. Требования к системе менеджмента сервисов" | Для каталога услуг, SLA, инцидентов, запросов, изменений, непрерывного улучшения и операционной модели поддержки |
| Информационная безопасность и ПДн | ГОСТ Р ИСО/МЭК 27001-2021, ГОСТ Р ИСО/МЭК 27002-2021, ГОСТ Р ИСО/МЭК 27017-2021, ГОСТ Р ИСО/МЭК 27018-2020; Федеральный закон N 152-ФЗ "О персональных данных"; приказ ФСТЭК России N 21 по мерам защиты ПДн | Для требований к защите записей, журналов, клиентских карточек, диалогов, аналитики, интеграций, облачной обработки и прав доступа |
| КИИ | Федеральный закон N 187-ФЗ "О безопасности критической информационной инфраструктуры Российской Федерации"; приказ ФСТЭК России N 239 по безопасности значимых объектов КИИ | Применять как условный слой, если сервис, узел связи, информационная система или заказчик попадает в контур КИИ. По умолчанию не присваивать всем SaaS-функциям |
| Реклама и маркетинговые коммуникации | Федеральный закон N 38-ФЗ "О рекламе", статья 18 о рекламе по сетям электросвязи | Для SMS-рассылок, исходящего обзвона, мессенджер-маркетинга, email-трекинга и callback-сценариев, если коммуникация имеет рекламный характер |
| AI и речевая аналитика | ГОСТ Р 71476-2024 "Искусственный интеллект. Концепции и терминология искусственного интеллекта"; ГОСТ Р 59277-2020 "Классификация систем искусственного интеллекта"; ГОСТ Р 59276-2020 "Способы обеспечения доверия"; ГОСТ Р 59898-2021 "Оценка качества систем искусственного интеллекта"; ГОСТ Р 71539-2024 "Процессы жизненного цикла системы искусственного интеллекта" | Для голосовых роботов, чат-ботов, речевой аналитики, робот-аналитика, робот-маркетолога и автоматизированной оценки качества |
| Качество ПО и архитектура | ГОСТ Р ИСО/МЭК 25010-2015 "Модели качества систем и программных продуктов"; ГОСТ Р ИСО/МЭК 12207-2010 "Процессы жизненного цикла программных средств"; ГОСТ Р 57100-2025 "Описание архитектуры" | Для функциональной пригодности, надежности, удобства, сопровождаемости, переносимости, жизненного цикла требований, API, интеграций и архитектурных описаний |
| ЦОД и инфраструктура | ГОСТ Р 58812-2020 "Центры обработки данных. Инженерная инфраструктура. Операционная модель эксплуатации"; ГОСТ Р 70139-2022 "Центры обработки данных. Инженерная инфраструктура. Классификация" | Для инфраструктурных NFR, размещения и эксплуатации платформы, если требование касается дата-центра, отказоустойчивости или инженерной инфраструктуры, а не только SaaS-функции |

## Правила применения выбранных стандартов

### TM Forum Frameworx / Open APIs

В этой работе TM Forum используется не как перечень "товарных карточек", а как доменная модель для телеком/SaaS-провайдера:

- **Market & Sales**: требования к продажам, маркетинговой аналитике, коммерческим предложениям, рекламным кампаниям и атрибуции.
- **Customer**: требования к клиенту, пользователю, обращению, коммуникации, SLA, качеству обслуживания и взаимодействию.
- **Product**: требования к продуктовой карточке, тарифу, опции, пакету, каталогу и заказу.
- **Service**: требования к логическому сервису: ВАТС, контакт-центр, IVR, робот, речевая аналитика, каналы коммуникаций.
- **Resource**: требования к ресурсам: номер, SIP trunk, канал, линия, устройство, запись разговора, интеграционный endpoint.

Open API слой нужен как ориентир для реализации и интеграций: продуктовые требования обычно связаны с каталогом и заказом, сервисные требования - с service inventory/order, клиентские обращения - с customer/party interaction, эксплуатационные требования - с trouble ticket, SLA, usage и monitoring.

### UNSPSC

UNSPSC используется как внешний кодировщик товарно-сервисного класса. Для SaaS-продукта часто нужны два уровня:

- обобщающий код **81162000 Cloud-based software as a service**;
- функциональный код, например **43232903 Contact center software**, **43232303 Customer relationship management CRM software**, **83111510 Interactive voice response service** или **80141501 Marketing analysis**.

Такой двойной подход уменьшает неоднозначность: требование "голосовой робот" является SaaS-сервисом, но функционально ближе к IVR, voice recognition и контакт-центру.

### BABOK Guide v3 (IIBA)

BABOK не классифицирует продукт, а отвечает на вопрос «как бизнес-аналитику работать с требованием к данному классу». В сравнительной таблице к каждой строке указана область знаний BABOK и наиболее релевантная техника:

- **Strategy Analysis** — для требований уровня выбора поставщика, импортозамещения и vendor-услуг (техники Vendor Assessment, Benchmarking and Market Analysis, Risk Analysis).
- **Requirements Analysis and Design Definition (RADD)** — для функциональных классов (Process Modelling, Interface Analysis, Decision Modelling, Business Rules Analysis, Data Modelling, Non-Functional Requirements Analysis, Prototyping).
- **Solution Evaluation** — для аналитических и метрических классов (Metrics and KPIs), а также для приёмки оборудования.

BABOK применяется как процессно-аналитический слой поверх продуктового: он не заменяет TM Forum/UNSPSC, а подсказывает технику выявления и проверки требования.

### Российский слой

Российский слой применяется не одним универсальным кодом, а связкой из трех типов ссылок:

- **ОКПД 2**: выбирать по предмету поставки или договора. Для MANGO OFFICE чаще всего нужны классы 61, 62.0 и 63.11, но конкретный код зависит от того, продается ли услуга связи, SaaS/ПО, обработка данных, интеграционная работа или оборудование.
- **ГОСТ/национальный стандарт**: выбирать по проверяемому аспекту требования. Например, для call center service quality - ГОСТ Р 55540-2013, для облачного SaaS - ГОСТ ISO/IEC 17788-2016 и ГОСТ Р 70860-2023, для ИБ - ГОСТ Р ИСО/МЭК 27001/27002/27017/27018.
- **НПА**: применять как обязательный compliance-триггер, если требование касается услуги связи, ПДн, рекламы, КИИ, передачи данных или телематической услуги. Этот слой должен быть проверен юристом или ответственным за compliance перед включением в договорные обязательства.

Практическое правило: в user story или ФТ достаточно указать российский слой на уровне "применимые стандарты/НПА". Точные юридические формулировки, лицензии, обязательность ГОСТ и финальные ОКПД 2-коды фиксируются в договоре, ТЗ или закупочной документации.

## Сравнительная таблица международной классификации

Колонки `Domain → Capability (v3.0)` и `BABOK` добавлены в версии 3.0. Строки 1–37 сохранены без изменений по содержанию; строки 38–42 — новые классы из анализа корпуса ТЗ (R2.1–R2.5).

| № | Продукт/сервис | Domain → Capability (v3.0) | MANGO OFFICE: есть/нет | Стандарт 1: TM Forum Frameworx / Open APIs (обоснование) | Стандарт 2: UNSPSC (обоснование) | Перспектива BABOK (область знаний / техника) |
| ---: | --- | --- | --- | --- | --- | --- |
| 1 | Виртуальная АТС / облачная телефония | voice-ucaas → cloud-pbx | Есть | Product Offering в Product domain; Service domain для голосового сервиса; Resource domain для номеров, линий и правил маршрутизации. | 81162000 Cloud-based software as a service + 83111500 Local and long distance telephone communications. | RADD: Functional Decomposition + Non-Functional Requirements Analysis (доступность, SLA) |
| 2 | IP-телефония и SIP trunk | voice-ucaas → sip-connectivity | Есть | Service/Resource: логический голосовой сервис поверх SIP-ресурсов; удобно отделять заказ продукта от ресурсов подключения. | 83111500 Local and long distance telephone communications; 43232901 Access software или 43232915 Platform interconnectivity software для софтверной части. | RADD: Interface Analysis (SIP-интерфейсы и подключение) |
| 3 | Виртуальные номера, 8-800, мобильные номера | voice-ucaas → number-management | Есть | Resource domain: номерная емкость как ресурс, привязанный к продукту ВАТС или контакт-центру. | 83111501 Local telephone service, 83111502 Long distance telephone services, 83111603 Cellular telephone services. | RADD: Business Rules Analysis (правила номерной ёмкости) + Data Modelling |
| 4 | Голосовое меню IVR, автосекретарь, автоинформатор | voice-ucaas → ivr-voice-menu | Есть | Service capability внутри голосового сервиса; требования относятся к service specification, routing и customer interaction. | 83111510 Interactive voice response service + 43232703 Interactive voice response software. | RADD: Process Modelling (IVR-сценарии) + Decision Modelling |
| 5 | Распределение звонков, очереди, правила маршрутизации | contact-center → call-routing | Есть | Customer/Service: управление взаимодействием и исполнением сервиса; для требований важны SLA, skill groups и правила маршрутизации. | 43232903 Contact center software или 43231501 Helpdesk or call center software. | RADD: Business Rules Analysis (маршрутизация) + NFR Analysis (SLA очередей) |
| 6 | Запись разговоров, журнал звонков, статистика | voice-ucaas → call-recording | Есть | Service assurance и usage: фиксация использования сервиса, контроль качества и доказательная база для обращений. | 43232300 Data management and query software + 43232605 Analytical or scientific software. | RADD: NFR Analysis (хранение, ИБ) + Data Modelling |
| 7 | Обратный звонок с сайта | voice-ucaas → callback | Есть | Market & Sales + Customer interaction: лидогенерация превращается в коммуникацию и заказ обратного вызова. | 80141603 Telemarketing + 83111500 Telephone communications. | Elicitation: Use Cases and Scenarios + RADD: Process Modelling |
| 8 | Mango Talker: корпоративный мессенджер и softphone | voice-ucaas → unified-communications | Есть | Customer interaction и Service: единое рабочее пространство коммуникаций; Resource - пользовательские endpoint-устройства и приложения. | 43232702 Desktop communications software + 43223204 Unified messaging platform. | RADD: Functional Decomposition + Interface Analysis |
| 9 | Видеоконференции | voice-ucaas → video-conferencing | Есть | Service domain для UCaaS-сервиса; Product domain для опции или отдельного предложения в каталоге. | 43233502 Video conferencing software + 81162000 Cloud-based software as a service. | RADD: Non-Functional Requirements Analysis (качество медиа) + Use Cases |
| 10 | SMS-рассылки | digital-channels → sms-messaging | Есть | Customer interaction и Campaign/Market & Sales: массовые уведомления и коммуникации с клиентами. | 43223202 Short message service center + 81161600 Electronic mail and messaging services. | RADD: Business Rules Analysis (согласия) + NFR Analysis |
| 11 | Омниканальный контакт-центр / CCaaS | contact-center → omnichannel-contact-center | Есть | Product/Service: отдельное Product Offering с capability обслуживания обращений; Customer domain для клиента и обращения. | 43232903 Contact center software + 43231501 Helpdesk or call center software. | RADD: Functional Decomposition + Solution Evaluation: Metrics and KPIs |
| 12 | Входящие обращения, очереди, рабочее место оператора | contact-center → agent-workspace | Есть | Customer interaction и Service assurance: управление обращением, оператором, каналом и SLA. | 43232903 Contact center software. | RADD: Process Modelling + Prototyping (рабочее место) |
| 13 | Исходящий обзвон и кампании | contact-center → outbound-calling | Есть | Market & Sales + Customer interaction: outbound-кампания как коммерческое взаимодействие, исполняемое контакт-центром. | 80141603 Telemarketing + 43232903 Contact center software. | RADD: Process Modelling + Business Rules Analysis (правила кампаний) |
| 14 | Омниканальные коммуникации: чат, мессенджеры, соцсети, email | digital-channels → omnichannel-messaging | Есть | Customer interaction across channels; полезно классифицировать канал отдельно от бизнес-сценария обращения. | 43223204 Unified messaging platform, 43223205 Instant messaging platform, 81161600 Electronic mail and messaging services. | RADD: Interface Analysis (каналы) + Process Modelling |
| 15 | Чат для сайта | digital-channels → website-chat | Есть | Customer interaction: цифровой канал обращения, связанный с контакт-центром и карточкой клиента. | 43233504 Instant messaging software + 81161600 Electronic mail and messaging services. | Elicitation: Use Cases and Scenarios + RADD: Prototyping |
| 16 | Чат-бот | ai-automation → chatbot | Есть | Service automation внутри Customer domain; бот исполняет часть interaction flow до передачи оператору. | 43231511 Expert system software + 43223205 Instant messaging platform. | RADD: Decision Modelling + Use Cases and Scenarios |
| 17 | Голосовой робот / voice bot | ai-automation → voice-bot | Есть | Service automation для голосового канала; связывает IVR, customer interaction и orchestration сценариев. | 43233413 Voice recognition software + 83111510 Interactive voice response service. | RADD: Decision Modelling + Process Modelling |
| 18 | Робот-администратор | ai-automation → process-robot | Есть | Service orchestration: автоматизирует операционные действия контакт-центра и обращения клиента. | 81112106 Application service providers + 43232403 Enterprise application integration software. | RADD: Process Modelling + Business Rules Analysis |
| 19 | Речевая аналитика / conversation intelligence | ai-automation → speech-analytics | Есть | Service assurance и Customer insight: анализ записей, транскриптов и качества коммуникаций. | 43233413 Voice recognition software + 43232605 Analytical or scientific software. | Solution Evaluation: Metrics and KPIs + Data Modelling |
| 20 | Управление качеством операторов (QM) | contact-center → quality-management | Есть | Service assurance: контроль качества, чек-листы, оценки и обратная связь по обслуживанию. | 43232606 Compliance software + 43231501 Helpdesk or call center software. | Solution Evaluation: Metrics and KPIs + Business Rules Analysis (чек-листы) |
| 21 | Workforce Management / управление рабочими ресурсами | contact-center → workforce-management | Есть | Resource/Enterprise management: планирование операторов как ресурса сервиса контакт-центра. | 43231505 Human resources software + 43232903 Contact center software. | Strategy Analysis: прогноз ресурса + RADD: Process Modelling |
| 22 | База знаний и скрипты операторов | contact-center → knowledge-base | Есть | Customer/Service support: knowledge artifacts поддерживают выполнение service interaction. | 43232200 Content management software + 43232201 Content workflow software. | RADD: Data Modelling + Document Analysis |
| 23 | Управление сделками / легкий CRM-сценарий | contact-center → deal-management | Есть | Customer + Market & Sales: связка клиента, сделки, коммуникации и коммерческого процесса. | 43232303 Customer relationship management CRM software. | RADD: Data Modelling + Process Modelling |
| 24 | Полноценная CRM как самостоятельная платформа | contact-center → crm-platform | Частично | TM Forum классифицирует как Customer/Sales capability, но в MANGO OFFICE публично виден скорее встроенный сценарий управления сделками и интеграции с внешними CRM. | 43232303 Customer relationship management CRM software. | Strategy Analysis: Vendor Assessment + RADD: Data Modelling |
| 25 | Интеграции с CRM, 1C, LDAP, marketplace | platform → platform-integration | Есть | Product/Service integration: интеграционные endpoints и партнерские системы вокруг основного продукта. | 43232403 Enterprise application integration software + 81112106 Application service providers. | RADD: Interface Analysis + Data Modelling |
| 26 | Open API, webhook, API для УВК/CRM | platform → open-api | Есть | Open API слой соответствует интеграционному подходу TM Forum: отделить продуктовый каталог, заказ, сервис и клиентские события от конкретного UI. | 43232403 Enterprise application integration software + 43232915 Platform interconnectivity software. | RADD: Interface Analysis (API-контракт) + NFR Analysis |
| 27 | Коллтрекинг | analytics → call-tracking | Есть | Market & Sales: атрибуция звонков к рекламным источникам; Service/Resource: динамические номера как ресурс. | 80141501 Marketing analysis + 83111500 Telephone communications. | Solution Evaluation: Metrics and KPIs + Data Modelling |
| 28 | Сквозная аналитика и ROMI | analytics → end-to-end-analytics | Есть | Market & Sales analytics: связывает коммуникации, расходы, лиды, сделки и выручку. | 80141501 Marketing analysis + 43232605 Analytical or scientific software. | Solution Evaluation: Metrics and KPIs (ROMI) + Financial Analysis |
| 29 | Мультиканальная аналитика и атрибуция | analytics → multichannel-analytics | Есть | Market & Sales + Customer insight: классифицирует требования к источникам, каналам и конверсиям. | 80141501 Marketing analysis. | Solution Evaluation: Metrics and KPIs + Data Modelling |
| 30 | Email-трекинг | analytics → email-tracking | Есть | Customer interaction + Market & Sales: email как канал коммуникации и атрибуции. | 43233501 Electronic mail software + 81161600 Electronic mail and messaging services. | Solution Evaluation: Metrics and KPIs + Business Rules Analysis (согласия) |
| 31 | Товарная аналитика / ecommerce analytics | analytics → product-analytics | Есть | Market & Sales: анализ спроса, товарных позиций и эффективности продаж. | 80141501 Marketing analysis + 43232307 Data mining software. | Solution Evaluation: Metrics and KPIs + Data Modelling (качество данных) |
| 32 | Анализ конкурентов | analytics → competitor-analysis | Есть | Market intelligence в Market & Sales domain; не является core-телеком сервисом, но поддерживает коммерческие решения. | 80141501 Marketing analysis + 80141500 Market research. | Strategy Analysis: Benchmarking and Market Analysis |
| 33 | Мессенджер-маркетинг | digital-channels → messenger-marketing | Есть | Market & Sales + Customer interaction: кампании в цифровых каналах, связанные с клиентскими событиями. | 43223205 Instant messaging platform + 81161601 Instant Messaging Administration Service. | RADD: Business Rules Analysis (согласия) + Use Cases and Scenarios |
| 34 | CPaaS / программируемые голосовые и messaging API | platform → cpaas | Частично | TM Forum позволяет оформить как API-enabled Product/Service; у MANGO OFFICE есть API/webhook, но публично не выделен полный CPaaS как отдельная товарная линейка. | 81112106 Application service providers + 43232403 Enterprise application integration software. | RADD: Interface Analysis (API) + NFR Analysis |
| 35 | Service desk / ITSM helpdesk | platform → service-desk | Частично | В TM Forum соответствует assurance, trouble ticket и customer problem; у MANGO OFFICE это ближе к контакт-центру, а не к самостоятельному ITSM-продукту. | 43231501 Helpdesk or call center software. | RADD: Process Modelling (ITSM) + Business Rules Analysis |
| 36 | Информационная безопасность | security → information-security | Есть | Enterprise/Security capability, поддерживающая доверие и эксплуатацию сервиса; не основной коммуникационный продукт. | 43233200 Security and protection software или смежные security-коды по актуальному UNSPSC. | RADD: NFR Analysis (ИБ) + Strategy Analysis: Risk Analysis |
| 37 | SIP-телефоны, гарнитуры и устройства | hardware → telephony-equipment | Вне SaaS-ядра | Resource domain: физические ресурсы доступа к сервису. В требованиях лучше отделять от SaaS-функциональности. | 43222800 Telephony equipment; 43222900 Telephony equipment accessories. | Solution Evaluation: Vendor Assessment + критерии приёмки |
| 38 | Маркировка номера, «карусельные номера», защита дозваниваемости | voice-ucaas → number-branding | Не выявлено | Resource domain: маркировка и ротация номерной ёмкости как resource-level сервис оператора связи; Market & Sales для калькуляции эффективности дозвона. | 83111500 Telephone communications + 80141501 Marketing analysis. | RADD: Business Rules Analysis (правила маркировки) + NFR Analysis (дозваниваемость) |
| 39 | Голосовые SMS / автоинформирование через голосовой канал | voice-ucaas → voice-sms-broadcast | Частично | Service automation для голосового канала + Market & Sales: массовое автоинформирование, отдельное от текстового SMS и от outbound-кампании. | 83111510 Interactive voice response service + 80141603 Telemarketing. | RADD: Process Modelling + Business Rules Analysis (согласия) |
| 40 | Self-Service портал клиента / личный кабинет заказчика SaaS | contact-center → self-service-portal | Частично | Customer self-service в Customer domain + Product: каталог самообслуживания, отделённый от operator workspace. | 81162000 Cloud-based software as a service + 43232703 Interactive voice response software (self-service). | RADD: Prototyping / UX + NFR Analysis (ПДн при самообслуживании) |
| 41 | Мобильное приложение оператора CCaaS | contact-center → operator-mobile-app | Частично | Customer interaction + Resource: мобильный endpoint оператора, отделённый от Mango Talker как UCaaS-инструмента сотрудника. | 43232702 Desktop communications software + 43232903 Contact center software. | RADD: Prototyping + NFR Analysis (мобильная платформа) |
| 42 | Услуги поддержки и развития CRM/SaaS как vendor-service | platform → vendor-support-services | Не выявлено | Partner/Enterprise: managed/professional services вокруг продукта (engaged party, agreement), а не сам продукт. | 80101507 Application maintenance services + 43232303 Customer relationship management CRM software. | Strategy Analysis: Vendor Assessment + Requirements Life Cycle Management |

## Сравнительная таблица к российским стандартам

Строки 38–42 (новые классы R2.1–R2.5) добавлены в версии 3.0; строки 1–37 сохранены без изменений.

| № | Продукт/сервис | Российская классификация | ГОСТ/НПА для проверки требований | Как использовать в документации |
| ---: | --- | --- | --- | --- |
| 1 | Виртуальная АТС / облачная телефония | ОКПД 2: услуги телекоммуникационные, SaaS/облачная услуга; при описании деятельности поставщика - ОКВЭД 2 класс 61/62/63 по роли | 126-ФЗ, ПП РФ N 1994, ГОСТ Р 53724-2009, ГОСТ Р 53731-2009, ГОСТ Р 53532-2009, ГОСТ ISO/IEC 17788-2016, ГОСТ Р ИСО/МЭК 20000-1-2021 | Фиксировать, что это услуга связи с облачным ПО; отдельно описывать номера, соединения, маршрутизацию, SLA, поддержку и границы ответственности оператора |
| 2 | IP-телефония и SIP trunk | ОКПД 2: услуги связи/передачи голоса и данных; при продаже API или ПО - класс 62.0 | 126-ФЗ, ПП РФ N 1994, ПП РФ N 2606 при передаче данных, ГОСТ Р 53532-2009, ГОСТ Р 53728-2009, ГОСТ Р 53724-2009 | В требованиях разделять голосовую услугу, канал передачи данных, SIP-интерфейс, качество соединения и параметры отказоустойчивости |
| 3 | Виртуальные номера, 8-800, мобильные номера | ОКПД 2: телекоммуникационные услуги и номерная емкость как ресурс услуги связи | 126-ФЗ, ПП РФ N 1994, ГОСТ Р 53731-2009, ГОСТ Р 53532-2009 | Указывать тип номера, правила подключения, переносимость/закрепление, тарификацию, маршрутизацию и ограничения по использованию |
| 4 | Голосовое меню IVR, автосекретарь, автоинформатор | ОКПД 2: услуга телефонии плюс программная функция контакт-центра | ПП РФ N 1994, ГОСТ Р 53532-2009, ГОСТ Р 55540-2013, ГОСТ Р 56087.3-2014 | Описывать IVR-сценарии, доступность службы, долю успешных обращений, правила информирования и передачу на оператора |
| 5 | Распределение звонков, очереди, правила маршрутизации | ОКПД 2: call-center/contact-center software или услуга связи в составе CCaaS | ГОСТ Р 55540-2013, ГОСТ Р 56087.3-2014, ГОСТ Р 53724-2009, ГОСТ Р ИСО/МЭК 20000-1-2021 | Фиксировать SLA очередей, skill-based routing, контрольные сроки, нагрузочные показатели и правила обработки исключений |
| 6 | Запись разговоров, журнал звонков, статистика | ОКПД 2: обработка данных/ПО/услуги связи в зависимости от договора | 152-ФЗ, приказ ФСТЭК N 21, ГОСТ Р ИСО/МЭК 27001-2021, ГОСТ Р ИСО/МЭК 27002-2021, ГОСТ Р ИСО/МЭК 27018-2020 | Описывать правовое основание записи, сроки хранения, доступы, выгрузки, аудит действий и обезличивание/удаление |
| 7 | Обратный звонок с сайта | ОКПД 2: телематическая/программная услуга и телефонная коммуникация | ПП РФ N 2607, ПП РФ N 1994, 152-ФЗ, 38-ФЗ при рекламном сценарии, ГОСТ Р 55540-2013 | Разделять web-форму, согласия, инициирование звонка, обработку ПДн и качество обработки обращения |
| 8 | Mango Talker: корпоративный мессенджер и softphone | ОКПД 2: программный продукт/SaaS и коммуникационная услуга | ГОСТ ISO/IEC 17788-2016, ГОСТ Р 70860-2023, ГОСТ Р ИСО/МЭК 25010-2015, ГОСТ Р ИСО/МЭК 27001-2021, ПП РФ N 2607 при телематической части | В ФТ разделять клиентское приложение, softphone, обмен сообщениями, авторизацию, хранение данных и требования к качеству ПО |
| 9 | Видеоконференции | ОКПД 2: SaaS/ПО для коммуникаций, телематическая услуга при предоставлении через сеть | ГОСТ ISO/IEC 17788-2016, ГОСТ Р 70860-2023, ГОСТ Р ИСО/МЭК 27017-2021, ГОСТ Р ИСО/МЭК 25010-2015, 152-ФЗ для записей и участников | Описывать роли участников, запись, хранение, доступность, качество медиасессии и разделение ответственности поставщика/потребителя облака |
| 10 | SMS-рассылки | ОКПД 2: телекоммуникационная/messaging услуга | 126-ФЗ, ПП РФ N 1994, 152-ФЗ, 38-ФЗ, ГОСТ Р 53724-2009 | В требованиях фиксировать источник согласий, тип сообщения, запрет/разрешение рекламного характера, журнал отправок и отказ от рассылки |
| 11 | Омниканальный контакт-центр / CCaaS | ОКПД 2: услуга центра обработки вызовов, SaaS, телематические каналы | ГОСТ Р 55540-2013, ГОСТ Р 56087.3-2014, ГОСТ Р 53724-2009, ГОСТ ISO/IEC 17788-2016, ГОСТ Р ИСО/МЭК 20000-1-2021 | Использовать как основной российский эталон для SLA контакт-центра, качества обработки обращений, процессов поддержки и облачной роли поставщика |
| 12 | Входящие обращения, очереди, рабочее место оператора | ОКПД 2: contact-center service/software | ГОСТ Р 55540-2013, ГОСТ Р 56087.3-2014, ГОСТ Р ИСО/МЭК 25010-2015, 152-ФЗ | Описывать доступность рабочего места, время ответа, обработку обращения, карточку клиента, права оператора и качество UI |
| 13 | Исходящий обзвон и кампании | ОКПД 2: call-center service, телемаркетинг/коммуникации | ГОСТ Р 55540-2013, 38-ФЗ, 152-ФЗ, ПП РФ N 1994, ГОСТ Р 56087.3-2014 | Фиксировать легальность базы контактов, согласия, сценарии дозвона, статус кампании, частотные ограничения и отказ от коммуникаций |
| 14 | Омниканальные коммуникации: чат, мессенджеры, соцсети, email | ОКПД 2: телематические услуги, SaaS/ПО, обработка данных | ПП РФ N 2607, 152-ФЗ, ГОСТ Р ИСО/МЭК 27001-2021, ГОСТ Р ИСО/МЭК 27018-2020, ГОСТ Р 55540-2013 | Разделять канал, обращение, идентификацию клиента, хранение переписки, операторский SLA и согласия на обработку данных |
| 15 | Чат для сайта | ОКПД 2: SaaS/телематический канал обслуживания | ПП РФ N 2607, 152-ФЗ, ГОСТ Р 56087.3-2014, ГОСТ Р 55540-2013, ГОСТ Р ИСО/МЭК 25010-2015 | Описывать виджет, сбор ПДн, уведомления, маршрутизацию, доступность и интеграцию с карточкой клиента |
| 16 | Чат-бот | ОКПД 2: AI/ПО/SaaS, цифровой канал обслуживания | ГОСТ Р 71476-2024, ГОСТ Р 59277-2020, ГОСТ Р 59276-2020, ГОСТ Р 59898-2021, ГОСТ Р 71539-2024, 152-ФЗ | Фиксировать назначение бота, уровень автоматизации, критерии качества ответа, fallback к оператору, обучение модели и обработку ПДн |
| 17 | Голосовой робот / voice bot | ОКПД 2: AI/телефонная услуга/contact-center automation | ГОСТ Р 71476-2024, ГОСТ Р 59277-2020, ГОСТ Р 59898-2021, ГОСТ Р 55540-2013, ПП РФ N 1994, 152-ФЗ | Описывать сценарии голосового взаимодействия, распознавание речи, информирование клиента, перевод на оператора, критерии качества и согласия |
| 18 | Робот-администратор | ОКПД 2: автоматизация сервисных процессов/ПО | ГОСТ Р ИСО/МЭК 20000-1-2021, ГОСТ Р ИСО/МЭК 12207-2010, ГОСТ Р ИСО/МЭК 25010-2015, при AI-функциях - ГОСТ Р 59277-2020 | Фиксировать автоматизируемый процесс, права робота, контроль действий, журналирование, исключения и ручное подтверждение критичных операций |
| 19 | Речевая аналитика / conversation intelligence | ОКПД 2: AI/аналитическое ПО, обработка данных и записей | ГОСТ Р 71476-2024, ГОСТ Р 59898-2021, ГОСТ Р ИСО/МЭК 27018-2020, 152-ФЗ, приказ ФСТЭК N 21 | Описывать состав анализируемых данных, транскрибацию, метрики качества, обезличивание, доступы к записям и хранение результатов анализа |
| 20 | Управление качеством операторов (QM) | ОКПД 2: contact-center quality management software/service | ГОСТ Р 55540-2013, ГОСТ Р 56087.3-2014, ГОСТ Р ИСО/МЭК 20000-1-2021, ГОСТ Р 59898-2021 при AI-оценке | Фиксировать чек-листы, выборки, автоматическую/ручную оценку, апелляции, метрики качества и связь с обучением операторов |
| 21 | Workforce Management / управление рабочими ресурсами | ОКПД 2: ПО планирования ресурсов/услуга контакт-центра | ГОСТ Р 55540-2013, ГОСТ Р ИСО/МЭК 25010-2015, ГОСТ Р ИСО/МЭК 20000-1-2021, 152-ФЗ для данных сотрудников | Описывать планирование смен, прогноз нагрузки, роли, трудовые/персональные данные, интеграцию с отчетностью и ограничения доступа |
| 22 | База знаний и скрипты операторов | ОКПД 2: ПО управления контентом/knowledge management | ГОСТ Р ИСО/МЭК 25010-2015, ГОСТ Р ИСО/МЭК 12207-2010, ГОСТ Р 55540-2013, ГОСТ Р ИСО/МЭК 27001-2021 | Фиксировать жизненный цикл статей, версионирование, согласование скриптов, поиск, доступы и связь с качеством обслуживания |
| 23 | Управление сделками / легкий CRM-сценарий | ОКПД 2: CRM/ПО и обработка клиентских данных | 152-ФЗ, приказ ФСТЭК N 21, ГОСТ Р ИСО/МЭК 25010-2015, ГОСТ Р ИСО/МЭК 27001-2021 | Описывать сущности клиента/сделки, правовые основания обработки ПДн, роли, историю коммуникаций, интеграции и экспорт |
| 24 | Полноценная CRM как самостоятельная платформа | ОКПД 2: CRM software/SaaS, но для MANGO OFFICE - частично/смежно | 152-ФЗ, ГОСТ Р ИСО/МЭК 25010-2015, ГОСТ Р ИСО/МЭК 12207-2010, ГОСТ Р ИСО/МЭК 27001-2021 | В документации не обещать самостоятельную CRM, если требование покрывается только встроенным сценарием или интеграцией с внешней CRM |
| 25 | Интеграции с CRM, 1C, LDAP, marketplace | ОКПД 2: услуги интеграции/ПО/API, обработка данных | ГОСТ Р ИСО/МЭК 12207-2010, ГОСТ Р ИСО/МЭК 25010-2015, ГОСТ Р 57100-2025, ГОСТ Р ИСО/МЭК 27001-2021, 152-ФЗ | Фиксировать интерфейсы, ответственность сторон, модель данных, права доступа, обработку ПДн, мониторинг и версионирование |
| 26 | Open API, webhook, API для УВК/CRM | ОКПД 2: программные интерфейсы/интеграционные услуги | ГОСТ Р 57100-2025, ГОСТ Р ИСО/МЭК 12207-2010, ГОСТ Р ИСО/МЭК 25010-2015, ГОСТ Р ИСО/МЭК 27001-2021 | Описывать контракт API, события, аутентификацию, лимиты, ошибки, SLA интеграций, backward compatibility и аудит вызовов |
| 27 | Коллтрекинг | ОКПД 2: телекоммуникационная услуга плюс маркетинговая аналитика | 126-ФЗ, ПП РФ N 1994, 152-ФЗ, 38-ФЗ, ГОСТ Р 53532-2009, ГОСТ Р ИСО/МЭК 27001-2021 | Разделять динамические номера, источник рекламного перехода, запись/аналитику звонка, согласия и правила хранения данных |
| 28 | Сквозная аналитика и ROMI | ОКПД 2: аналитическое ПО/SaaS и обработка данных | 152-ФЗ, ГОСТ Р ИСО/МЭК 25010-2015, ГОСТ Р ИСО/МЭК 27001-2021, ГОСТ Р ИСО/МЭК 27018-2020 | Описывать источники данных, идентификаторы клиента, модели атрибуции, точность расчетов, доступы, ретеншн и обезличивание |
| 29 | Мультиканальная аналитика и атрибуция | ОКПД 2: аналитическое ПО/SaaS | 152-ФЗ, 38-ФЗ при рекламных данных, ГОСТ Р ИСО/МЭК 25010-2015, ГОСТ Р ИСО/МЭК 27001-2021 | Фиксировать каналы, правила дедупликации, согласия, ограничения использования рекламных идентификаторов и прозрачность методики атрибуции |
| 30 | Email-трекинг | ОКПД 2: email/messaging analytics software/service | 152-ФЗ, 38-ФЗ, ГОСТ Р ИСО/МЭК 27001-2021, ГОСТ Р ИСО/МЭК 25010-2015 | Описывать согласия, события открытия/перехода, хранение email-адресов, отписку, цель обработки и доступы |
| 31 | Товарная аналитика / ecommerce analytics | ОКПД 2: аналитическое ПО, обработка данных | 152-ФЗ при клиентских данных, ГОСТ Р ИСО/МЭК 25010-2015, ГОСТ Р ИСО/МЭК 27001-2021, при data quality - ГОСТ Р ИСО 8000-2-2014 | Описывать источники ecommerce-данных, качество данных, расчеты, роли доступа и границы ответственности за внешние данные |
| 32 | Анализ конкурентов | ОКПД 2: маркетинговые/аналитические информационные услуги | 149-ФЗ, ГОСТ Р ИСО/МЭК 25010-2015, ГОСТ Р ИСО/МЭК 27001-2021 | Фиксировать источники данных, частоту обновления, ограничения на использование внешних данных и то, что функция не является услугой связи |
| 33 | Мессенджер-маркетинг | ОКПД 2: messaging/marketing automation software/service | 152-ФЗ, 38-ФЗ, ПП РФ N 2607, ГОСТ Р ИСО/МЭК 27001-2021 | Описывать каналы, согласия, шаблоны, отказ от рассылки, ограничения платформ мессенджеров и журнал отправок |
| 34 | CPaaS / программируемые голосовые и messaging API | ОКПД 2: телекоммуникационные API, SaaS/API, интеграционные услуги | 126-ФЗ, ПП РФ N 1994, ПП РФ N 2606, ПП РФ N 2607, ГОСТ Р 53724-2009, ГОСТ Р 53728-2009, ГОСТ Р ИСО/МЭК 27017-2021 | В требованиях явно отделять операторскую услугу связи от программируемого API, фиксировать роли сторон, лимиты, качество, безопасность и согласия |
| 35 | Service desk / ITSM helpdesk | ОКПД 2: ПО/service management, но для MANGO OFFICE - смежный сценарий | ГОСТ Р ИСО/МЭК 20000-1-2021, ГОСТ Р ИСО/МЭК 25010-2015, ГОСТ Р ИСО/МЭК 27001-2021 | Не смешивать с CCaaS: если нужен внутренний ITSM, применять ГОСТ Р ИСО/МЭК 20000-1 и описывать отдельный процесс инцидентов/запросов |
| 36 | Информационная безопасность | ОКПД 2: security software/service, compliance-layer для всех сервисов | ГОСТ Р ИСО/МЭК 27001-2021, ГОСТ Р ИСО/МЭК 27002-2021, ГОСТ Р ИСО/МЭК 27017-2021, ГОСТ Р ИСО/МЭК 27018-2020, 152-ФЗ, приказ ФСТЭК N 21, 187-ФЗ/приказ ФСТЭК N 239 при КИИ | Описывать ИБ как сквозное требование: классификация данных, модель доступа, журналы, инциденты, облачные роли, ПДн и условные требования КИИ |
| 37 | SIP-телефоны, гарнитуры и устройства | ОКПД 2: оборудование связи и аксессуары; вне SaaS-ядра | 126-ФЗ для средств связи и подтверждения соответствия, эксплуатационная документация производителя, ГОСТ Р 53724-2009 как контекст качества услуги | Отделять аппаратную поставку от SaaS-функции; фиксировать совместимость, сертификацию/декларации, гарантию и ответственность за эксплуатацию устройства |
| 38 | Маркировка номера, «карусельные номера», защита дозваниваемости | ОКПД 2: 61.10.xx телекоммуникационные услуги (resource-level сервис оператора связи) | 126-ФЗ, ПП РФ N 1994, 38-ФЗ при рекламном характере коммуникации | Фиксировать тип маркировки/ротации номеров, согласование с оператором, влияние на дозваниваемость, тарификацию и рекламный контекст |
| 39 | Голосовые SMS / автоинформирование через голосовой канал | ОКПД 2: 61.10/61.20 телекоммуникационная услуга/IVR-автоинформирование | 126-ФЗ, 38-ФЗ, ПП РФ N 1994, 152-ФЗ, ГОСТ Р 55540-2013 | Отделять голосовое автоинформирование от текстового SMS и от outbound-кампании; фиксировать согласия, рекламный характер, подтверждение доставки и журнал |
| 40 | Self-Service портал клиента / личный кабинет заказчика SaaS | ОКПД 2: 62.0/63.11 SaaS/ПО самообслуживания | ГОСТ ISO/IEC 17788-2016, ГОСТ Р ИСО/МЭК 25010-2015, 152-ФЗ | Описывать сценарии самообслуживания, аутентификацию, доступ к записям/услугам, UX и обработку ПДн при самообслуживании |
| 41 | Мобильное приложение оператора CCaaS | ОКПД 2: 62.0 ПО/SaaS, мобильное рабочее место оператора | ГОСТ Р 55540-2013, ГОСТ Р ИСО/МЭК 25010-2015, 152-ФЗ | Отделять от Mango Talker; описывать мобильную обработку обращений, push-уведомления, офлайн-режим, безопасность устройства и качество ПО |
| 42 | Услуги поддержки и развития CRM/SaaS как vendor-service | ОКПД 2: 62.0 услуги сопровождения/доработки ПО (vendor services) | ГОСТ Р ИСО/МЭК 12207-2010, ГОСТ Р ИСО/МЭК 20000-1-2021 | Фиксировать предмет услуги (поддержка/доработка), SLA, scope изменений, ответственность сторон и лицензионную модель доработок |

## Рабочая таксономия для входящих требований

Для практического использования в backlog можно завести поля:

| Поле | Пример значения | Зачем нужно |
| --- | --- | --- |
| Product family | `CCaaS / Контакт-центр` | Быстрая маршрутизация требования к продуктовой зоне |
| Mango status | `Есть`, `Частично`, `Не выявлено` | Понимание, является ли требование развитием существующего продукта или новым классом |
| Mango product | `Омниканальный контакт-центр` | Привязка к публичному или внутреннему каталогу продуктов |
| TM Forum domain | `Customer`, `Product`, `Service`, `Resource`, `Market & Sales` | Единый доменный язык для аналитики и архитектуры |
| TM Forum capability | `Customer interaction`, `Product catalog`, `Service assurance`, `Usage`, `Resource management` | Уточнение типа требования |
| UNSPSC code | `43232903 Contact center software` | Внешняя классификация для сравнения поставщиков и закупки |
| ОКПД 2 class | `61`, `62.0`, `63.11` | Российская закупочная/договорная классификация предмета поставки |
| Russian standards overlay | `ГОСТ Р 55540-2013`, `ГОСТ Р ИСО/МЭК 27018-2020`, `ПП РФ N 2607` | Российские ГОСТ/НПА, которые нужно проверить при описании SLA, ИБ, ПДн и договорных условий |
| Compliance trigger | `ПДн`, `реклама`, `услуга связи`, `КИИ`, `нет` | Быстрое указание, нужен ли дополнительный юридический/compliance-review |
| Requirement relation | `Core feature`, `Option`, `Integration`, `Process`, `Hardware`, `Out of scope` | Связь требования с продуктом |

В версии 3.0 к этим продуктовым полям добавляется отдельный закупочный слой (`tariff-model`, `contract-duration`, `license-model`, `procurement-format`, `certification-registry`, `vendor-qualification`, `confidentiality-terms`). Он описан в §«🛒 Commercial Layer» и заполняется независимо от продуктового ключа.

Примеры:

- "Нужно принимать обращения из Telegram, WhatsApp, сайта и email в одном окне": Product family `CCaaS / Digital channels`; Mango status `Есть`; TM Forum `Customer interaction`; UNSPSC `43223204 Unified messaging platform` и `43232903 Contact center software`; ОКПД 2 `62.0/63.11` или телематический слой по предмету договора; Russian standards overlay `ГОСТ Р 55540-2013`, `ПП РФ N 2607`, `152-ФЗ`.
- "Нужно автоматически оценивать все звонки операторов по чек-листу": Product family `AI / QM`; Mango status `Есть`; TM Forum `Service assurance`; UNSPSC `43233413 Voice recognition software` и `43232606 Compliance software`; Russian standards overlay `ГОСТ Р 59898-2021`, `ГОСТ Р 55540-2013`, `152-ФЗ`, приказ ФСТЭК N 21.
- "Нужно полноценное ITSM-решение для внутренних инцидентов ИТ": Product family `Adjacent ITSM`; Mango status `Частично/не core`; TM Forum `Assurance / trouble ticket`; UNSPSC `43231501 Helpdesk or call center software`; Russian standards overlay `ГОСТ Р ИСО/МЭК 20000-1-2021`; рекомендация - не смешивать с CCaaS и сравнивать как отдельный процессный слой.

## 🚀 Возможные улучшения (не активны в v3.0)

Раздел фиксирует атрибуты, которые проявились в анализе корпуса ТЗ (`classification-tz.md`, рекомендации R2.6–R2.8), но осознанно **не вносятся** в основную модель v3.0. Они не являются продуктовыми классами и при преждевременном включении раздули бы таксономию (нарушение Anti-Inflation principle, см. [governance/REPO_MODEL.md](../../governance/REPO_MODEL.md)). Каждый атрибут описан с обоснованием отсрочки и критерием активации в будущей версии.

### R2.6 — Атрибут «модель сценарирования» бота

- **Описание**: атрибут со значениями `vendor-managed / customer-configured / mixed` для классов `voice-bot` (row 17) и `chatbot` (row 16): кто авторизует и сопровождает сценарий — поставщик, заказчик или совместно.
- **Почему отложено**: это не отдельный класс продукта, а атрибут операционной модели уже существующих классов. Корпус ТЗ (TZ 26/29) разделяет программируемого Заказчиком/Исполнителем робота, но пока этого недостаточно, чтобы выделять Feature.
- **Критерий активации**: когда ≥3 ТЗ потребуют сравнивать ботов именно по авторству сценария, ввести Feature `scenario-authoring-model` в классы `voice-bot` и `chatbot` со значениями-параметрами `vendor-managed | customer-configured | mixed`.

### R2.7 — Атрибут «Industry vertical»

- **Описание**: контекстный тег отрасли требования: `generic / hr-recruiting / logistics-delivery / healthcare-mis / finance / e-commerce / energy-utility / telco-reseller`.
- **Почему отложено**: вертикаль описывает контекст применения, а не продуктовый класс; голосовой робот в HR-сценарии остаётся тем же `voice-bot` (row 17). Преждевременное включение в продуктовую иерархию размыло бы границу «продукт vs сценарий применения».
- **Критерий активации**: когда отраслевой шаблон станет самостоятельным продуктовым предложением (отдельный каталожный SKU/тариф), а не просто настройкой существующего класса; до этого вертикаль уместна как тег в backlog БА, а не в эталоне.

### R2.8 — Compliance-значение «Реестр российского ПО (Минцифры)»

- **Описание**: дополнить compliance trigger значением `Реестр российского ПО (Минцифры)` и связать его с классами 1, 11, 16, 17, 19, 25, 26 (продукты, по которым закупка регулярно требует подтверждения импортозамещения).
- **Почему отложено**: это не продуктовая capability, а закупочно-нормативный признак. Его естественное место — закупочное поле `certification-registry` в §«🛒 Commercial Layer», а не продуктовая иерархия. До формализации процедуры импортозамещения он остаётся compliance-overlay.
- **Критерий активации**: когда закупка начнёт использовать наличие в реестре как gating-фильтр (а не справочный признак), вынести его как обязательное значение поля `certification-registry` и добавить ссылку на реестр в §«Источники» (уже добавлена ниже как подготовительный шаг).

## Рекомендации по ведению стандарта

1. Вести классификацию как живой справочник в репозитории: один Markdown-источник и HTML-версию для просмотра без Markdown-рендера.
2. Для каждого нового требования сначала выбирать product family, затем Mango status, затем TM Forum domain/capability, UNSPSC-код, ОКПД 2-класс и российский standards/compliance overlay.
3. Если требование не укладывается в текущие классы, добавлять строку в расширенный список со статусом `Не выявлено` или `Частично`, а не смешивать ее с существующим продуктом.
4. Для коммерческих и закупочных документов использовать UNSPSC; для архитектуры, интеграций и декомпозиции требований использовать TM Forum.
5. Для российских закупок и договоров использовать ОКПД 2 как отдельное поле; ОКВЭД 2 использовать только для описания деятельности поставщика, а не как замену продуктовому коду.
6. Для требований поддержки, SLA, инцидентов и service desk дополнительно помечать ITIL/ISO 20000 или ГОСТ Р ИСО/МЭК 20000-1, потому что эти фреймворки лучше описывают процессы эксплуатации, но не заменяют продуктовую классификацию.
7. Для требований с ПДн, рекламными коммуникациями, услугами связи или КИИ ставить явный compliance trigger и передавать финальную формулировку ответственным за правовую/ИБ-проверку.
8. Заполнять продуктовый ключ (`Domain → Capability → Feature → Atomic Function`) и закупочный слой (`Commercial Layer`) независимо: смешение «что делает продукт» и «на каких условиях он закупается» снижает сравнимость требований.

## Источники

- MANGO OFFICE, публичный каталог продуктов: <https://www.mango-office.ru/products/>
- MANGO OFFICE, Виртуальная АТС: <https://www.mango-office.ru/products/virtualnaya_ats/>
- MANGO OFFICE, Контакт-центр: <https://www.mango-office.ru/products/contact-center/>
- MANGO OFFICE, Интеграции по API: <https://www.mango-office.ru/products/integraciya/api/>
- MANGO OFFICE, Голосовой робот: <https://www.mango-office.ru/products/contact-center/ai/voice-robot/>
- MANGO OFFICE, Чат-бот: <https://www.mango-office.ru/products/contact-center/vozmozhnosti/chat-bot/>
- MANGO OFFICE, Речевая аналитика: <https://www.mango-office.ru/products/virtualnaya_ats/vozmozhnosti/speech-analytics/>
- MANGO OFFICE, Коллтрекинг: <https://www.mango-office.ru/products/calltracking/>
- MANGO OFFICE, Мультиканальная аналитика: <https://www.mango-office.ru/products/calltracking/vozmozhnosti/multichannel-analytics/>
- TM Forum, Business Process Framework (eTOM): <https://www.tmforum.org/business-process-framework/>
- TM Forum, Information Framework (SID): <https://www.tmforum.org/oda/information-systems/information-framework-sid/>
- TM Forum, TMF620 Product Catalog Management API: <https://www.tmforum.org/resources/standard/tmf620-product-catalog-management-api-rest-specification-r14-5-0/>
- IIBA, A Guide to the Business Analysis Body of Knowledge (BABOK Guide) v3: <https://www.iiba.org/career-resources/a-business-analysis-professionals-foundation-for-success/babok/>
- UNDP, United Nations Standard Products and Services Code: <https://www.undp.org/unspsc>
- UNGM, UNSPSC browser and Excel export: <https://www.ungm.org/Public/UNSPSC>
- PeopleCert, ITIL 4 practices overview: <https://www.peoplecert.org/ITIL4-practices>
- ISO, ISO/IEC 20000-1:2018 service management system requirements: <https://www.iso.org/standard/70636.html>
- MEF, Lifecycle Service Orchestration APIs: <https://www.mef.net/service-automation/lso-apis/>
- ОКПД 2, раздел J "Услуги в области информации и связи": <https://base.garant.ru/70650730/d866c9989c75bef029b67e7a33698205/>
- ОКВЭД 2, раздел J "Деятельность в области информации и связи": <https://classifikators.ru/okved/J>
- Федеральный закон N 126-ФЗ "О связи": <https://www.consultant.ru/document/cons_doc_LAW_43224/>
- Федеральный закон N 149-ФЗ "Об информации, информационных технологиях и о защите информации": <https://www.consultant.ru/document/cons_doc_LAW_61798/>
- Федеральный закон N 152-ФЗ "О персональных данных": <https://www.consultant.ru/document/cons_doc_LAW_61801/>
- Федеральный закон N 187-ФЗ "О безопасности критической информационной инфраструктуры Российской Федерации": <https://www.consultant.ru/document/cons_doc_LAW_220885/>
- Федеральный закон N 38-ФЗ "О рекламе": <https://www.consultant.ru/document/cons_doc_LAW_58968/>
- Постановление Правительства РФ N 1994 "Об утверждении Правил оказания услуг телефонной связи": <https://www.consultant.ru/document/cons_doc_LAW_494901/>
- Постановление Правительства РФ N 2606 "Об утверждении Правил оказания услуг связи по передаче данных": <https://www.consultant.ru/document/cons_doc_LAW_406300/>
- Постановление Правительства РФ N 2607 "Об утверждении Правил оказания телематических услуг связи": <https://www.consultant.ru/document/cons_doc_LAW_406301/>
- Приказ ФСТЭК России N 21 по мерам защиты персональных данных: <https://www.consultant.ru/document/cons_doc_LAW_146520/>
- Приказ ФСТЭК России N 239 по безопасности значимых объектов КИИ: <https://www.consultant.ru/document/cons_doc_LAW_294287/>
- Реестр российского ПО (Минцифры России): <https://reestr.digital.gov.ru/>
- ГОСТ Р ИСО/МЭК 20000-1-2021: <https://protect.gost.ru/gost/details/dd4227f1-d238-4214-9863-cac1c2dcb841>
- ГОСТ ISO/IEC 17788-2016: <https://docs.cntd.ru/document/1200141425>
- ГОСТ Р 70860-2023: <https://docs.cntd.ru/document/1302614749>
- ГОСТ Р ИСО/МЭК 27001-2021: <https://docs.cntd.ru/document/1200181890>
- ГОСТ Р ИСО/МЭК 27002-2021: <https://docs.cntd.ru/document/1200179669>
- ГОСТ Р ИСО/МЭК 27017-2021: <https://protect.gost.ru/gost/details/45ba3c1b-e9a9-43b4-9365-a608ed81aa02>
- ГОСТ Р ИСО/МЭК 27018-2020: <https://protect.gost.ru/gost/details/9d572a3b-7f35-43a1-853d-ad316d63e798>
- ГОСТ Р 53724-2009, ГОСТ Р 53731-2009, ГОСТ Р 53532-2009, ГОСТ Р 53728-2009 и ГОСТ Р 56087.3-2014 по качеству услуг связи: <https://docs.cntd.ru/search?q=%D0%BA%D0%B0%D1%87%D0%B5%D1%81%D1%82%D0%B2%D0%BE%20%D1%83%D1%81%D0%BB%D1%83%D0%B3%20%D1%81%D0%B2%D1%8F%D0%B7%D0%B8%20%D0%93%D0%9E%D0%A1%D0%A2%20%D0%A0>
- ГОСТ Р 55540-2013 по качеству услуги центра обработки вызовов: <https://docs.cntd.ru/document/1200106675>
- ГОСТ Р 71476-2024, ГОСТ Р 59277-2020, ГОСТ Р 59276-2020, ГОСТ Р 59898-2021 и ГОСТ Р 71539-2024 по искусственному интеллекту: <https://docs.cntd.ru/search?q=%D0%93%D0%9E%D0%A1%D0%A2%20%D0%A0%20%D0%B8%D1%81%D0%BA%D1%83%D1%81%D1%81%D1%82%D0%B2%D0%B5%D0%BD%D0%BD%D1%8B%D0%B9%20%D0%B8%D0%BD%D1%82%D0%B5%D0%BB%D0%BB%D0%B5%D0%BA%D1%82>
- ГОСТ Р ИСО/МЭК 25010-2015, ГОСТ Р ИСО/МЭК 12207-2010, ГОСТ Р 57100-2025 и ГОСТ Р ИСО 8000-2-2014 для качества ПО, жизненного цикла, архитектуры и качества данных: <https://docs.cntd.ru/search?q=%D0%93%D0%9E%D0%A1%D0%A2%20%D0%A0%20%D0%98%D0%A1%D0%9E%20%D0%9C%D0%AD%D0%9A%2025010%2012207%2057100%208000-2>
- ГОСТ Р 58812-2020 и ГОСТ Р 70139-2022 по ЦОД: <https://docs.cntd.ru/search?q=%D0%93%D0%9E%D0%A1%D0%A2%20%D0%A0%2058812%2070139>
