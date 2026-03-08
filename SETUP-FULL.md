# Полная настройка пула

**8562** — ваша панель с вашими монетами. **8563** — Web UI для Setup DB / Generate Config. **8561** — дашборд (таблица пулов).

---

## 1. Установить приложения

| Приложение | Порт | Назначение |
|------------|------|------------|
| **MiningCore** | 8560 | Ядро пула |
| **Pool Config (мои монеты)** | 8562 | Ваша панель — список ваших монет из coins.json |
| **Pool Config (Web UI)** | 8563 | Setup Database Schema, Refresh Master Coin List, Generate Pool Config File, замена "xxx" |
| **Pool Dashboard** | 8561 | Таблица пулов, статистика |

Приложения **без привязки к MiningCore** — можно ставить в любом порядке. Pool Config (8562), Web UI (8563), Pool Dashboard (8561) — сборка из репо (build на устройстве).

---

## 2. Загрузить coins.json

По SSH на Umbrel:

```bash
mkdir -p /home/umbrel/.miningcore
curl -sSL -o /home/umbrel/.miningcore/coins.json "https://raw.githubusercontent.com/Sert1985n/umbrel-pool-app-store/main/templates/coins.json"
docker restart sert-umbrel-pool-miningcore_server_1
sleep 15
docker restart sert-umbrel-pool-pool-config_web_1
docker restart sert-umbrel-pool-miningcore-webui_web_1
```

Либо скрипт:  
`curl -sSL -o /tmp/install-coins-json.sh "https://raw.githubusercontent.com/Sert1985n/umbrel-pool-app-store/main/scripts/install-coins-json.sh" && sh /tmp/install-coins-json.sh`

---

## 3. Настроить пулы

1. Откройте **http://ВАШ-IP:8562** — ваша панель с вашими монетами.
2. Нажмите **«Setup Database Schema / Generate Pool Config File → открыть на порту 8563»** — откроется **http://ВАШ-IP:8563** (MiningCore Web UI).
3. На 8563: **Refresh Master Coin List** → **Setup Database Schema** → **Generate Pool Config File** → замените "xxx" на адреса кошельков → сохраните.
4. В Umbrel: **Apps → MiningCore → Restart**.

---

## 4. Проверка

- **http://ВАШ-IP:8561** — Pool Dashboard (таблица пулов).
- **http://ВАШ-IP:8562** — ваша панель (мои монеты).
- **http://ВАШ-IP:8563** — Web UI (Setup DB, Generate Config).
