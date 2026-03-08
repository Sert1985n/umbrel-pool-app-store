# Полная настройка пула — один раз, всё работает

Одна панель конфигурации (8562). Установка приложений → загрузка монет → настройка пулов и кошельков → дашборд 8561.

---

## 1. Установить приложения в Umbrel

В **App Store** установите по порядку:

| Приложение | Порт | Зачем |
|------------|------|--------|
| **MiningCore** | 8560 | Ядро пула (API на 4000) |
| **Pool Config (MiningCore Web UI)** | 8562 | **Одна панель**: Setup DB, Refresh Coin List, Generate Config, кошельки. Без сборки — только образ theretromike/miningcorewebui. |
| **Pool Dashboard** | 8561 | Таблица пулов, статистика, графики |

При необходимости установите ноды нужных монет (BTC, BCH, XEC и т.д.) — см. README.

---

## 2. Один раз: загрузить список монет

По **SSH на Umbrel** выполните одну команду:

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
```

Подождите 15–20 секунд.

---

## 3. Настроить пулы и кошельки (одна панель — 8562)

1. Откройте **http://ВАШ-IP:8562** — откроется MiningCore Web UI.
2. Перейдите в **Pool Configuration**. Выполните по порядку:
   - **Refresh Master Coin List** — подтянутся монеты из `coins.json`.
   - **Setup Database Schema** — если ещё не делали.
   - **Generate Pool Config File** — создаётся `config.json` с пулами.
3. В сгенерированном конфиге замените **"xxx"** на ваши адреса кошельков. Сохраните конфиг.
4. В Umbrel: **Apps → MiningCore → Restart**. Подождите 10–15 секунд.

---

## 4. Проверить результат

- **http://ВАШ-IP:8561** — **Pool Dashboard**: таблица пулов. Если пусто — выполните шаг 3 и перезапустите MiningCore.
- **http://ВАШ-IP:8562** — единственная панель конфигурации (Setup DB, Refresh, Generate Config, кошельки).

Конфиги на сервере: **/home/umbrel/.miningcore/config.json** и **coins.json**. Ноды — **guides/CONFIG-DAEMONS.md**.
