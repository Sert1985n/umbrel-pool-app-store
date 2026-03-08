# Полная настройка пула — один раз, всё работает

Одна инструкция: установка приложений → загрузка монет → настройка пулов и кошельков → дашборд с таблицей пулов.

---

## 1. Установить приложения в Umbrel

В **App Store** (ваш магазин приложений) установите по порядку:

| Приложение | Порт | Зачем |
|------------|------|--------|
| **MiningCore** | 8560 | Ядро пула (API на 4000) |
| **Pool Config** | 8562 | Панель: Setup DB, Refresh Coin List, Generate Config, кошельки |
| **Pool Config (наши монеты)** | 8563 | Список 28 монет + кнопка «Открыть Pool Config» |
| **Pool Dashboard** | 8561 | Таблица пулов, статистика, графики |

При необходимости установите ноды нужных монет (BTC, BCH, XEC и т.д.) — см. список в README.

---

## 2. Один раз: загрузить список монет и перезапустить сервисы

По **SSH на Umbrel** выполните **одну** команду (скрипт скачает `coins.json` с 28 монетами и перезапустит MiningCore и панели):

```bash
curl -sSL -o /tmp/install-coins-json.sh "https://raw.githubusercontent.com/Sert1985n/umbrel-pool-app-store/main/scripts/install-coins-json.sh" && sh /tmp/install-coins-json.sh
```

Либо вручную:

```bash
mkdir -p /home/umbrel/.miningcore
curl -sSL -o /home/umbrel/.miningcore/coins.json "https://raw.githubusercontent.com/Sert1985n/umbrel-pool-app-store/main/templates/coins.json"
docker restart sert-umbrel-pool-miningcore_server_1
sleep 15
docker restart sert-umbrel-pool-pool-config_web_1
docker restart sert-umbrel-pool-custom-panel_web_1
```

Подождите 15–20 секунд.

---

## 3. Настроить пулы и кошельки (Pool Config)

1. Откройте в браузере **http://ВАШ-IP:8562** (или с страницы 8563 нажмите **«Открыть Pool Config (порт 8562)»**).
2. В панели **Pool Configuration** выполните по порядку:
   - **Refresh Master Coin List** — подтянутся все 28 монет из `coins.json`.
   - **Setup Database Schema** — если ещё не делали.
   - **Generate Pool Config File** — создаётся `config.json` с пулами.
3. В сгенерированном конфиге замените плейсхолдеры **"xxx"** на ваши адреса кошельков для выплат. Сохраните конфиг.
4. В панели на 8562 нажмите **«Перезапустить MiningCore»** (или перезапустите приложение MiningCore в Umbrel).

---

## 4. Проверить результат

- **http://ВАШ-IP:8561** — **Pool Dashboard**: таблица пулов (Pool, Algorithm, Miners, Hashrate и т.д.). Если таблица пустая — убедитесь, что в шаге 3 выполнили Generate Pool Config и перезапустили MiningCore.
- **http://ВАШ-IP:8563** — список наших 28 монет и кнопка перехода на Pool Config (8562).
- **http://ВАШ-IP:8562** — полная панель настройки (Refresh, Setup DB, Generate Config, кошельки, перезапуск MiningCore).

---

## Порты и ссылки

| URL | Назначение |
|-----|------------|
| **:8560** | MiningCore (внутри Dozzle; API :4000) |
| **:8561** | Pool Dashboard — таблица пулов, статистика |
| **:8562** | Pool Config — Setup DB, Refresh, Generate Config, кошельки |
| **:8563** | Список 28 монет + кнопка «Открыть Pool Config» |

Конфиги на сервере: **/home/umbrel/.miningcore/config.json** и **coins.json**. Ноды для пула — см. **guides/CONFIG-DAEMONS.md**.
