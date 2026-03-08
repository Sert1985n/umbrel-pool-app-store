# Исправление ошибки XEC: "Name or service not known (xec:9007)"

Ошибка значит: Miningcore пытается подключиться к ноде eCash по адресу **xec:9007**, но имя хоста `xec` не разрешается (нет DNS или записи в hosts).

---

## Одна команда (один ввод)

Скопируйте и вставьте в терминал на сервере:

```bash
grep -q '^127\.0\.0\.1[[:space:]]*xec' /etc/hosts || echo "127.0.0.1 xec" | sudo tee -a /etc/hosts; C=$(sudo grep -rl '"xec"' /opt /etc 2>/dev/null | grep -i config | head -1); C=${C:-/opt/miningcore/config.json}; sudo sed -i.bak 's/"host"[[:space:]]*:[[:space:]]*"xec"/"host": "127.0.0.1"/g' "$C"; sudo systemctl restart miningcore; sudo journalctl -u miningcore -f -n 30
```

Если сервис называется не `miningcore`, в конце замените оба `miningcore` на имя вашего сервиса (например `pool`).

---

## Шаги в одном порядке (выполнить на сервере пула)

### 1. Найти конфиг Miningcore

Обычно это `config.json` в папке, откуда запускается пул, например:
- `/opt/miningcore/config.json`
- или каталог, указанный в systemd: `sudo systemctl status miningcore` → смотреть `WorkingDirectory`

```bash
# Пример поиска
sudo find / -name "config.json" 2>/dev/null | head -5
```

### 2. Найти секцию пула XEC и адрес демона

Откройте конфиг:

```bash
sudo nano /path/to/config.json
```

Найдите блок пула **xec** (по `"id": "xec"` или `"coin": "xec"`). Внутри будет секция **daemons** (или **daemon**), например:

```json
"daemons": [
  { "host": "xec", "port": 9007 }
]
```

или

```json
"daemons": [
  { "host": "xec", "port": 9007, "user": "...", "password": "..." }
]
```

Адрес `"host": "xec"` и нужно заменить на реальный хост.

### 3. Указать правильный хост демона

**Вариант A — нода XEC на том же сервере**

Замените хост на localhost:

```json
"host": "127.0.0.1"
```

(порт 9007 оставьте, если нода слушает на 9007).

**Вариант B — нода на другом сервере**

Замените на IP или доменное имя той машины:

```json
"host": "192.168.1.100"
```

или

```json
"host": "xec-node.example.com"
```

**Вариант C — оставить имя "xec", но прописать его в hosts**

Если хотите оставить имя `xec`, добавьте запись в `/etc/hosts` (где `IP` — адрес машины с нодой XEC):

```bash
echo "IP xec" | sudo tee -a /etc/hosts
# пример:
echo "127.0.0.1 xec" | sudo tee -a /etc/hosts
```

После этого перезапустите Miningcore (см. шаг 4).

### 4. Перезапустить Miningcore

```bash
sudo systemctl restart miningcore
# или как у вас называется сервис, например:
# sudo systemctl restart pool
```

### 5. Проверить логи

Через 10–20 секунд ошибка `[xec] Daemon reports: Name or service not known` должна пропасть, в логах может появиться успешное подключение к демону:

```bash
sudo journalctl -u miningcore -f -n 50
```

---

## Если ноды XEC ещё нет

Тогда нужно сначала поднять ноду eCash (Bitcoin ABC / eCash node) на порту 9007 (или другом) и в конфиге Miningcore указать её хост и порт, как в шагах 2–3. Пока ноды нет, пул XEC будет писать "Waiting for daemons to come online" — это ожидаемо.

---

## Кратко

| Проблема | Решение |
|----------|--------|
| `Name or service not known (xec:9007)` | В config.json заменить `"host": "xec"` на `127.0.0.1` (если нода локально) или на IP/имя сервера с нодой; либо добавить в `/etc/hosts`: `IP xec` |
| После правки | `sudo systemctl restart miningcore` |

После исправления адреса демона XEC пул начнёт получать networkStats, и на центральной странице дашборда появятся Network Hashrate и Network Difficulty для XEC.
