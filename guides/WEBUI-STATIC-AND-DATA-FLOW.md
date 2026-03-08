# Веб-UI пула: статика, coins.json и wallet-адреса

Как устроены статические файлы, куда кладётся и кто читает coins.json, где добавляются wallet-адреса. **Pool Dashboard (8561) остаётся как есть** — только показывает данные из API.

По документу **«веб-UI пула) статические файлы не лежат как в обычном сайте»**: у MiningCore Web UI нет простой папки с index.html + .js/.css — страницы отдаёт сервер, статика лежит внутри образа в `/app/wwwroot`.

---

## 1. Где лежат статические файлы

| Приложение | Порт | Как отдаётся статика | Где лежат файлы |
|------------|------|----------------------|------------------|
| **Pool Dashboard** | 8561 | Nginx: обычный сайт из папки | В образе: `COPY www /usr/share/nginx/html/` → index.html, app.js, site.css, assets/ в `/usr/share/nginx/html`. Запросы `/api/` проксируются на MiningCore :4000. **Статика — как в обычном сайте.** |
| **Pool Config** | 8562 | Образ theretromike/miningcorewebui | **Статика НЕ лежит как в обычном сайте.** Внутри контейнера: `/app/wwwroot/` — css/site.css, js/site.js, img/, lib/, MiningCoreWebUI.styles.css. Файла index.html нет — HTML отдаёт сервер (Razor/ASP.NET). Страницы (Index, PoolConfiguration и т.д.) — серверные маршруты. Править стили/логотип можно только внутри образа (wwwroot) или пересборкой; конфиги пишутся в /app/miningcore/ (монтировано с хоста). |
Итого: у **Dashboard (8561)** статика — как в обычном сайте (nginx, одна папка). У **Pool Config (8562)** статика в `/app/wwwroot`, индекс и страницы — серверные, не файл index.html.

### Как устроен Pool Config (8562) внутри образа

- В контейнере: `/app/wwwroot/` — статика (css, js, img, lib). Страницы рендерятся сервером, нет «обычного» index.html.
- Шаблоны пулов: `/app/pooltemplate.json` и по монетам — `/app/btctemplate.json`, `/app/dogetemplate.json`, `/app/xectemplate.json` и т.д. Панель собирает из них итоговый конфиг.
- Результат пишется в **/app/miningcore/** (на хосте это `/home/umbrel/.miningcore/`): `config.json` и при необходимости `coins.json`. Список монет для чекбоксов и кнопка **Refresh Master Coin List** берутся из coins.json на сервере. Подробнее — **guides/COINS-JSON-SETUP.md**.

---

## 2. Куда и как попадает coins.json

- **Единственное место на сервере:** `/home/umbrel/.miningcore/coins.json` (хост Umbrel).

**Кто его подменяет/записывает:**
- Не приложения 8561/8562. Замену делаете вы:
  - **Скрипт:**  
    `curl -sSL -o /tmp/install-coins-json.sh "https://raw.githubusercontent.com/.../scripts/install-coins-json.sh" && sh /tmp/install-coins-json.sh`  
    Скрипт скачивает `templates/coins.json` из репозитория и записывает в `/home/umbrel/.miningcore/coins.json`, затем перезапускает MiningCore, Pool Config и Pool Config (наши монеты).
  - **Вручную:**  
    `curl -sSL -o /home/umbrel/.miningcore/coins.json "https://raw.githubusercontent.com/Sert1985n/umbrel-pool-app-store/main/templates/coins.json"`  
    (и при необходимости перезапуск контейнеров.)

**Кто читает:**
- **MiningCore** — монтирует файл как `/app/build/coins.json`, использует для списка монет и конфигурации пулов.
- **Pool Config (8562)** — монтирует каталог `/home/umbrel/.miningcore` в `/app/miningcore`, читает оттуда coins.json для Refresh Master Coin List и генерации config.

---

## 3. Где добавляются wallet-адреса (адрес пула для выплат)

- **Только в Pool Config (8562).**  
  В панели MiningCore Web UI: **Generate Pool Config File** создаёт/обновляет `config.json` в `/home/umbrel/.miningcore/`. В сгенерированном конфиге плейсхолдеры **"xxx"** вы заменяете на реальные адреса кошельков пула. Сохранение и перезапуск MiningCore — из той же панели или вручную.

- **Pool Dashboard (8561)** адреса в config **не добавляет и не меняет**.  
  Он только:
  - получает данные из MiningCore API (`/api/pools` и др.);
  - показывает, в том числе, адрес пула (`pool.address`) из конфига;
  - поле «Your Wallet» — для поиска майнера по адресу; значение хранится в **localStorage** в браузере и никуда на сервер не отправляется.

То есть подстановка «xxx» → реальный wallet делается только в 8562; 8561 только отображает то, что уже есть в config и отдаёт API.

---

## 4. Pool Dashboard (8561) — без изменений

- Статика: как сейчас — nginx, файлы из `www/` в образе.
- Данные: только чтение из MiningCore API (прокси `/api/` на MiningCore :4000).
- coins.json и config.json Dashboard не читает и не пишет.
- «Your Wallet» — только локальный ввод для поиска майнера (localStorage).

Никаких изменений в логике или размещении статики для 8561 не вносится; дашборд остаётся как есть.

---

## 5. Fee wallet и rewardRecipients (как в «панели 83»)

В вашем документе **«панель 83, где fee wallet и fee % (0.05) в rewardRecipients, кнопка Auto Wallet»** описан отдельный Node-сервис с доступом на запись к каталогу config MiningCore. Он монтирует этот каталог как `/mc:rw` и может править `config.json` (добавлять fee wallet, rewardRecipients с percentage 0.05, подставлять адрес пула). В текущем Umbrel-наборе такой панели нет: Pool Config (8562) — это только образ theretromike/miningcorewebui (Generate Config, замена «xxx» вручную). Добавить fee/rewardRecipients можно вручную в config.json или реализовать отдельное приложение по аналогии с панелью 83 (Node + rw mount к `/home/umbrel/.miningcore`).

---

## 6. Краткая схема

```
[Хост Umbrel]
  /home/umbrel/.miningcore/coins.json   ← подмена: скрипт или curl (из репо)
  /home/umbrel/.miningcore/config.json  ← генерируется и правится в 8562, "xxx" → wallet

MiningCore (8560)     читает coins.json + config.json
Pool Config (8562)    читает/пишет оба файла (папка .miningcore), подстановка "xxx"
Pool Dashboard (8561)  только API MiningCore, статика из www/ — без изменений
```
