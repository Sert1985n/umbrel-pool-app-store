# Кратко: что не так и что делать

Все правки из этого репозитория **уже записаны в GitHub** (https://github.com/Sert1985n/umbrel-pool-app-store). После изменений делаются `git add`, `git commit`, `git push`. Чтобы увидеть их на Umbrel, нужно обновить магазин.

---

## 1. «Моей панели нет» и «иконки не добавились»

**Причина:** Umbrel кэширует список приложений и иконки магазина. Пока вы не обновите источник, новые приложения и иконки не появятся.

**Что сделать:**

1. В Umbrel: **Settings → Community App Stores** (или **App Store → Источники**).
2. Найдите магазин **Umbrel Pool** (URL `https://github.com/Sert1985n/umbrel-pool-app-store`).
3. Нажмите **Update** / **Refresh** / **Обновить** для этого магазина.
4. Если кнопки нет — **удалите** этот источник и **добавьте снова** тот же URL, затем откройте магазин и проверьте список.

После обновления в списке появятся приложения **«Моя панель — Pool Dashboard»** (порт 8560), **«Pool Dashboard (Моя панель)»** (порт 8561) и иконки.

---

## 2. Referral Links и Support Me не удалены, копирайт не изменился

**MiningCore Web UI** взят полностью из [Retro Mike store](https://github.com/TheRetroMike/retromike-umbrel-app-store) — тот же образ и структура, без правок. Образ Docker менять нельзя, поэтому Referral Links, Support Me и копирайт убираются **только в браузере** — через userscript или букмарклет.

**Что сделать:** откройте **guides/NATIVE-WEBUI-CUSTOMIZE.md** и установите Tampermonkey + скрипт или добавьте букмарклет. После этого при открытии http://ВАШ-IP:8559 пункты и копирайт будут скрыты/заменены.

---

## 3. В списке Pool Configuration нет моих монет

**Причина:** Список монет на странице Pool Configuration берётся из файла **coins.json** на сервере Umbrel. Если там нет шаблонов для ваших монет — их не будет в списке.

**Что сделать:**

1. Положить на сервер **coins.json** в `/home/umbrel/.miningcore/coins.json` (формат и шаблоны — из репозитория [Miningcore](https://github.com/coinfoundry/miningcore)).
2. Перезапустить Miningcore:  
   `docker restart sert-umbrel-pool-miningcore_server_1`
3. Открыть http://192.168.0.244:8559/PoolConfiguration и нажать **Refresh Master Coin List**.

Подробнее: **guides/POOL-CONFIGURATION-COINS.md**.

---

## 4. Изменения и GitHub

Да, правки в репозитории **сразу записываются в GitHub**: после правок выполняется commit и push в https://github.com/Sert1985n/umbrel-pool-app-store. Чтобы Umbrel подтянул новые приложения и иконки, нужно **обновить магазин** (п. 1).
