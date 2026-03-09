# Полный отчёт по проекту Umbrel Pool App Store

Документ описывает, как создавался проект, что настраивали, какие изменения вносили в панель (Pool Dashboard) и как всё это воспроизвести с нуля.

---

## 1. Что такое проект

**Umbrel Pool App Store** — это community app store для Umbrel с приложениями для майнинг-пула на базе MiningCore.

- **Репозиторий:** https://github.com/Sert1985n/umbrel-pool-app-store  
- **Магазин в Umbrel:** добавляется по ссылке на репозиторий; после Update отображаются приложения.
- **Две веб-панели:**
  - **Порт 8563** — родная MiningCore Web UI (Setup Database Schema, Refresh Master Coin List, Generate Pool Config File).
  - **Порт 8561** — своя панель **Pool Dashboard** (статистика пулов, монет, майнеров, графики, кошелёк).

---

## 2. Как создавали проект

1. **Базовый магазин** взят за основу из [TheRetroMike/retromike-umbrel-app-store](https://github.com/TheRetroMike/retromike-umbrel-app-store): структура `umbrel-app-store.yml`, приложения с `umbrel-app.yml` и `docker-compose.yml`.
2. **Свой репозиторий** создан на GitHub (Sert1985n/umbrel-pool-app-store), в него перенесены и переименованы приложения с префиксом `sert-umbrel-pool-`.
3. **Порты и контейнеры** заданы так, чтобы не конфликтовать с Umbrel и друг с другом (см. раздел 3).
4. **Список монет** описан в `coins-reference.json`; по нему генерируются конфиги и списки в панели.
5. **Pool Dashboard (моя панель)** вынесен в отдельное приложение `sert-umbrel-pool-poolui` на порт 8561; статика лежит в `sert-umbrel-pool-poolui/poolui/` (HTML, CSS, JS, иконки).

---

## 3. Порты и приложения

| Приложение | Порт | Назначение |
|------------|------|------------|
| sert-umbrel-pool-miningcore | 8560 | MiningCore — ядро пула |
| sert-umbrel-pool-poolui | **8561** | **Pool Dashboard** — ваша панель (статистика, графики, кошелёк) |
| sert-umbrel-pool-miningcore-webui | **8563** | Родная MiningCore Web UI (Setup DB, Refresh Coin List, Generate Config) |
| sert-umbrel-pool-btc-node, sert-umbrel-pool-bch-node, … | — | Ноды монет (без внешних портов, только для MiningCore) |
| sert-umbrel-pool-postgres | 5050 | PostgreSQL + pgAdmin |
| sert-umbrel-pool-dozzle | — | Просмотр логов контейнеров |

Имена контейнеров в Umbrel: `sert-umbrel-pool-<app>_<service>_1` (например `sert-umbrel-pool-miningcore_server_1`, `sert-umbrel-pool-poolui_web_1`). Для нод: `sert-umbrel-pool-<coin>-node_node_1` (DGB: `_digibyted_1`). Полная таблица — в `guides/PORTS-AND-CONTAINERS.md` и `guides/NETWORK-PORTS.md`.

---

## 4. Настройка бэкенда (один раз)

- **coins-reference.json** — справочник монет (id, coin, stratum, rpcPort). Используется для генерации конфигов и отображения в панели.
- **coins.json на сервере** — кладётся в `/home/umbrel/.miningcore/coins.json` (скачать из `templates/coins.json` или сгенерировать; при необходимости правится XEC/другие монеты).
- **config.json** — `/home/umbrel/.miningcore/config.json`; генерируется в Web UI (8563) кнопкой Generate Pool Config File; в нём задаются пулы, daemons (host = контейнер ноды), кошельки, fee.
- **Действия на 8563:** Refresh Master Coin List → Setup Database Schema → Generate Pool Config File → подставить кошельки вместо "xxx" → сохранить config → перезапуск MiningCore в Umbrel.

Подробно: `SETUP-FULL.md`, `guides/POOL-CONFIG-ACTIONS.md`, `guides/COINS-JSON-SETUP.md`, `guides/CONFIG-DAEMONS.md`.

---

## 5. Всё, что настраивали и меняли в панели (Pool Dashboard)

Панель — это приложение **sert-umbrel-pool-poolui**; файлы: `poolui/index.html`, `poolui/app.js`, `poolui/site.css`, `poolui/img/*.png` (иконки монет).

### 5.1. Структура и данные

- **API:** запросы к `/api` (прокси к MiningCore): `/api/pools`, `/api/pools/{id}`, `/api/pools/{id}/miners`, `/api/pools/{id}/miners/{addr}`, блоки, выплаты.
- **Цены:** CoinGecko (через CORS-прокси при необходимости); кэш цен по pool id/symbol.
- **Роутинг:** хэш-навигация `#/`, `#/coin/{id}`, `#/blocks/{id}`, `#/miners/{id}`, `#/miner/{id}/{addr}/dashboard` и т.д.

### 5.2. Центральная страница (список пулов)

- Таблица: Pool, Algorithm, Miners, Hashrate, Network Hashrate, Network Difficulty, Current Price, Price.
- **BTC всегда первый** в списке: сортировка по id/symbol (btc/bitcoin в начало), остальные — как есть.
- Колонка **Price** (вместо «Reward» с текстом «block»): только цена и изменение в % с тонкими стрелками (зелёная вверх, красная вниз); без слова "block".
- **Компактный вид:** класс `surface--compact` — уменьшенные отступы и шрифты таблицы и карточек.

### 5.3. Страница монеты (Coin)

- Блоки: POOL STATISTICS, BLOCK STATISTICS, CURRENT PRICE, NETWORK STATISTICS в сетке 4 колонки; под ними Your Wallet, затем Hashrate Chart, затем карточки Algorithm, Reward Scheme, Block Reward, Pool Fee.
- **График (Hashrate Chart):**
  - Две серии: Pool Hashrate (синяя линия), Network Difficulty (оранжевая линия с заливкой под кривой).
  - Заливка только у оранжевой (Network Difficulty), синяя — без заливки.
  - Линии ограничены областью графика (clip по прямоугольнику), чтобы ничего не рисовалось «за полями».
  - При наведении на график показывается тултип **только для той серии, к которой ближе курсор** (по расстоянию до точки на кривой).
  - Левая ось (H/s) и синяя линия скрываются, когда Pool Hashrate = 0 (нет «демо»-полосы).
- Текст про подтверждение блоков локализован («Для подтверждения блока требуется N новых блоков в сети»).
- Таблица блоков и блок-статистика — на всю ширину; стили в `site.css` (blocks-summary-wrap, blocks-summary-table).

### 5.4. Панель майнера (Miner)

- **Заголовок графика:** только «Hashrate Chart», без подписи «— Current (30m) / Average (1h)».
- **График майнера:**
  - Две серии: Current Hashrate (30m) и Average Hashrate (1h). **Без заливки** (и синяя, и оранжевая — только линии), параметр `fillB: false` в `renderChartDual`.
  - Сглаживание серий (`smoothChartSeries`), чтобы линия не «летала» и не прыгала.
  - Область рисования та же: clip по прямоугольнику графика.
- Над графиком полоска: Height, Difficulty, Block, Time (обновляются при тике).
- **Карточка WORK:**
  - **Share Sum** — в компактном формате (2–3 цифры + единица K/M/G): функция `fmtShareSum`.
  - **Found** — при отсутствии найденных блоков показывается **0**, не прочерк.
  - Элементы с id `mShareSum`, `mEffort`, `mFound` обновляются при каждом тике (данные из `fetchMinerStats`).
- **Last Best Share / Best Share:** добавлены алиасы полей API (в т.ч. из объекта майнера `row`); при значении 0 показывается «0», не прочерк.
- **Таблица воркеров:** колонки Worker, Hashrate (30m), Hashrate (1h), Valids, Invalid, Stale, Best Share, Port, Last Share. Для текущего майнера подставляются данные из объекта `row`, если в элементе воркера их нет (чтобы Valids, Invalid, Stale и т.д. не были пустыми).
- **Имя воркера:** используется `workerName`, `name`, `label`, `worker` (строка или объект), часть адреса после точки (например `addr.rig1` → rig1); иначе fallback «Worker N».
- В колонке Worker отображается **только имя**, без адреса кошелька.

### 5.5. Обновление данных и скорость

- **Интервалы опроса:** пулы и майнеры — 2 с; график майнера (realtime) — 3 с; цены — 20 с.
- При **смене вкладки/страницы** сразу вызывается обновление для текущего экрана (`scheduleImmediateRefresh`): список пулов, страница монеты, список майнеров, панель майнера.
- При первой загрузке страницы пулов и монеты данные запрашиваются параллельно: `Promise.all([loadPools(), refreshPrices()])`.

### 5.6. Внешний вид и компактность

- Класс **surface--compact** применён к страницам: список пулов, страница монеты, панель майнера. Уменьшены отступы таблиц (4px 8px), карточек, заголовков и шрифты (10–11px), чтобы меньше прокручивать.
- Стили для изменения цены: `.chg.up` / `.chg.down` с тонкими стрелками (зелёная вверх, красная вниз).

### 5.7. Иконки

- **В панели:** иконки монет из папки `poolui/img/` (файлы `{id}.png`, fallback `generic.png`); базовый путь `img/`.
- **В магазине Umbrel:** иконки в репозитории в `store-icons/`; в `umbrel-app.yml` указываются как `https://raw.githubusercontent.com/Sert1985n/umbrel-pool-app-store/main/store-icons/<name>.png`. Для части приложений (Miningcore, Dozzle, Miningcore Web UI, PostgreSQL) использованы внешние URL по необходимости.

### 5.8. Прочее

- Локализация текста созревания блоков; подпись «Found» вместо «Blocks» в карточке WORK.
- Обработка разных имён полей в ответах API (алиасы для poolStats, miner stats, workers).
- Таймаут и повтор запросов к API; при ошибках отображение прочерков или нулей без падения интерфейса.

---

## 6. Инструкция: как создать такой проект с нуля

### Шаг 1. Репозиторий и структура магазина

1. Создать репозиторий на GitHub (например `my-umbrel-pool-store`).
2. В корне создать `umbrel-app-store.yml`:
   - `version`, `id`, `name` (название магазина).
3. Для каждого приложения создать папку, например `my-pool-miningcore`, `my-pool-dashboard`, и в ней:
   - `umbrel-app.yml` (manifest: id, name, category, version, port, icon, description и т.д.),
   - `docker-compose.yml` (сервисы, порты, переменные окружения, volumes),
   - при необходимости `Dockerfile` (например для своей панели на nginx).

### Шаг 2. MiningCore и Web UI

1. Добавить приложение MiningCore (образ, порт 8560, volumes для config/coins).
2. Добавить приложение с родным MiningCore Web UI на порт 8563 (Setup DB, Refresh Coin List, Generate Config).
3. Указать в Web UI или в документации пути к config.json и coins.json на сервере Umbrel (например `/home/umbrel/.miningcore/`).

### Шаг 3. Своя панель (Pool Dashboard)

1. Создать приложение (например `my-pool-poolui`) с портом 8561.
2. В папке приложения:
   - `Dockerfile`: образ на базе nginx (или другого веб-сервера), копирование статики в `/usr/share/nginx/html`.
   - `poolui/` (или `www/`): index.html, app.js, site.css, img/ с иконками.
3. В `app.js` задать базовый URL API (например `/api`) и при необходимости прокси к MiningCore на бэкенде.
4. Настроить docker-compose: один сервис (web), порт 8561, при необходимости `APP_HOST`/`APP_PORT` для Umbrel.

### Шаг 4. Список монет и конфиги

1. Создать `coins-reference.json` с массивом монет (id, coin, stratum, rpcPort).
2. Подготовить шаблон или готовый `coins.json` для сервера (в репо в `templates/` или в документации).
3. В документации описать: Refresh Master Coin List → Setup Database Schema → Generate Pool Config File, подстановка кошельков, перезапуск MiningCore.

### Шаг 5. Ноды монет

1. Для каждой монеты (или группы) создать приложение-ноду с своим docker-compose (образ ноды, без конфликтующих портов снаружи).
2. В config.json MiningCore в daemons указать host = имя контейнера ноды (как в Umbrel: `my-pool-btc-node_node_1` и т.д.).
3. Проверить, что имена контейнеров и порты не пересекаются (см. `guides/PORTS-AND-CONTAINERS.md`).

### Шаг 6. Обновления в Umbrel

1. В `umbrel-app-store.yml` при изменениях магазина увеличивать `version`.
2. В каждом `umbrel-app.yml` при изменениях приложения увеличивать `version`.
3. После push в GitHub в Umbrel: App Store → нужный магазин → **Update** (Refresh), чтобы подтянулись новые версии.

### Шаг 7. Проверка

1. Добавить магазин в Umbrel по URL репозитория.
2. Установить MiningCore, Web UI, Pool Dashboard, при необходимости ноды.
3. Загрузить coins.json, выполнить Setup DB и Generate Config на 8563, перезапустить MiningCore.
4. Открыть 8561 — панель должна показывать пулы, монеты, майнеров, графики и кошелёк.

---

## 7. Ключевые файлы проекта

| Файл | Назначение |
|------|------------|
| **umbrel-app-store.yml** | Версия и id магазина; при правках поднимать version и пушить. |
| **coins-reference.json** | Справочник монет (id, stratum, rpcPort) для конфигов и панели. |
| **sert-umbrel-pool-poolui/poolui/app.js** | Вся логика панели: API, графики, таблицы, форматирование, опрос. |
| **sert-umbrel-pool-poolui/poolui/site.css** | Стили, в т.ч. surface--compact, таблицы, карточки, .chg. |
| **sert-umbrel-pool-poolui/poolui/index.html** | Точка входа панели. |
| **sert-umbrel-pool-poolui/Dockerfile** | Сборка образа панели (nginx + статика). |
| **sert-umbrel-pool-miningcore/docker-compose.yml** | Сервис MiningCore, порты, volumes. |
| **sert-umbrel-pool-miningcore-webui/** | Родная Web UI на 8563. |
| **store-icons/** | Иконки приложений для магазина (ссылки в umbrel-app.yml). |
| **SETUP-FULL.md** | Краткая полная настройка. |
| **README.md** | Описание магазина, приложений, ссылки на гайды. |
| **guides/POOL-CONFIG-ACTIONS.md** | Setup DB, Refresh, Generate Config, монеты. |
| **guides/PORTS-AND-CONTAINERS.md** | Порты и имена контейнеров без конфликтов. |

---

## 8. Запись изменений в GitHub

- Все изменения в коде панели, манифестах, конфигах и документации хранятся в репозитории.
- Типичная последовательность:
  - `git add .`
  - `git commit -m "краткое описание изменений"`
  - `git push origin main`
- После push в Umbrel нажать **Update** у магазина Umbrel Pool, чтобы подтянуть новые версии приложений и панели.

---

## 9. Последние изменения (калибровка, сужение, прочерки)

- **Ширина страницы:** контент ограничен по ширине: `max-width: 1200px` у `.wrap`, чтобы страница не была «сильно растянута» слева направо.
- **График на странице монеты (Hashrate Chart):** оранжевая линия (Network Difficulty) **без заливки** — как синяя (Pool Hashrate), параметр `fillB: false` в `drawCoinChart`. Обе линии рисуются только линией, без заливки; каждая по своей шкале (слева H/s, справа G).
- **Прочерки убраны:** везде, где ожидается число, вместо «—» показывается значение по умолчанию:
  - **BLOCK STATISTICS:** Current Effort → `0%`, Last Block → `0`, если данных нет.
  - **CURRENT PRICE:** при отсутствии цены → `$0`, Price BTC → `0.00000000 BTC`.
  - **Таблица блоков (64/128/256/1024):** Effort → `0%` вместо «—».
  - **Таблица блоков (Height, Type, Time, …):** пустые поля заменены на `0`, `n/a` или значение из API (Type: `b.type ?? b.blockType`, Server: `b.server ?? b.host`, Miner, Solution: `b.solution ?? b.shareDifficulty ?? b.solver`, Reward: `b.reward ?? b.blockReward` и т.д.).
  - **REWARD (панель майнера):** Unconfirmed, Balance, Pending → `0` при отсутствии данных.
- **Обновление статистики:** интервалы опроса уменьшены (пулы/майнеры 1,5 с, график майнера 2 с, цены 15 с) для более быстрого отклика после перехода по вкладкам.
- **График:** без заливки оранжевой полосы на странице монеты и в панели майнера; сглаживание серий в панели майнера сохранено, чтобы линия не «летала».

### 9.1. Страница «Miners» и имя воркера

- **Страница «… — Miners» (список майнеров пула):** оставлены только три колонки — **Адрес**, **Hashrate**, **Last Share**. Колонка «Worker» удалена; в строках выводятся только короткий адрес (например `bitcoincas…mrf7me`), hashrate и last share. При отсутствии данных в Last Share выводится «0».
- **Имя воркера в панели майнера:** если API не отдаёт отдельное имя (workerName, name, label, часть адреса после точки), вместо «Worker 1» выводится **уникальный хвост адреса** (последние 6 символов с «…», например `…mrf7me`), чтобы отображалось реальное отличие майнеров, а не только «Worker N».
- **Last Best Share, Best Share, Port Difficulty:** при отсутствии данных выводятся «0», не прочерк.
- **Таблица воркеров на панели майнера:** во всех ячейках (Hashrate 30m/1h, Valids, Invalid, Stale, Best Share, Port, Last Share) при отсутствии данных выводится «0» или «0 H/s», прочерки не используются.
- **Инструкция:** полный отчёт и шаги по созданию проекта — в этом документе (разделы 1–8 и 9); все изменения панели и бэкенда описаны в разделах 5, 9 и 9.1.

### 9.2. Ссылки на эксплорер (все монеты)

- **Клик по адресу или блоку** открывает соответствующий блок-эксплорер в новой вкладке. Для каждой монеты используются свои эксплореры:
  - **XEC (eCash):** адрес → `https://explorer.e.cash/address/...`, блок → `https://explorer.e.cash/block/...`
  - **BCH:** blockchair.com/bitcoin-cash/address, block
  - **BTC, BC2, FB, BSV, DOGE, LTC, RVN, VTC, XMR, FLUX, KAS** — свои URL в `explorerAddr()` и `explorerBlock()` в `app.js`.
- **Где добавлены ссылки:**
  - **Страница монеты (Your Wallet):** кнопка «Open in explorer» рядом с полем кошелька — открывает текущий адрес в эксплорере выбранной монеты.
  - **Статистика блоков:** в таблице блоков колонки **Height** и **Miner** — кликабельные ссылки (Height → блок в эксплорере, Miner → адрес в эксплорере).
  - **Страница «Miners»:** колонка **Адрес** — каждый адрес ведёт в эксплорер (клик по ссылке не переводит на дашборд майнера; переход на дашборд — по клику по строке).
  - **Панель майнера:** адрес под заголовком и иконка — ссылки на эксплорер.
  - **Help:** кошелёк пула уже имел иконку «Open in explorer».
- Функции в `app.js`: `explorerAddr(poolId, addr)`, `explorerBlock(poolId, height)`, `openWalletExplorer(poolId)`.

---

*Документ обновлён: раздел 9.2 (ссылки на эксплорер для адресов и блоков на всех монетах).*
