# Родная MiningCore Web UI — убрать Referral Links, Support Me, свой копирайт

В интерфейсе родной MiningCore Web UI (образ theretromike/miningcorewebui) по умолчанию есть пункты меню **Referral Links** и **Support Me**, а внизу — **Copyright © 2025 Retro Mike Tech All rights reserved.**

Чтобы **удалить** эти надписи и заменить копирайт на **public-pool-btc.ru All rights reserved.**, можно использовать пользовательский скрипт (userscript).

---

## Вариант 1: Tampermonkey / Violentmonkey

1. Установите расширение браузера **Tampermonkey** ([Chrome](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo)) или **Violentmonkey**.
2. Откройте панель расширения → «Добавить новый скрипт».
3. Вставьте содержимое файла **scripts/native-webui-public-pool-btc.userscript.js** из этого репозитория (или скопируйте его ниже).
4. Сохраните скрипт.
5. Откройте страницу родной MiningCore Web UI (например `http://umbrel.local:8559` или ваш хост/порт). Скрипт сам:
   - удалит пункты меню **Referral Links** и **Support Me**;
   - заменит текст в футере на **Copyright © 2025 public-pool-btc.ru All rights reserved.**

Скрипт по умолчанию запускается на `umbrel.local`, `localhost`, `127.0.0.1`, `*.local`. Если родная Web UI открыта по другому адресу (например IP), в Tampermonkey добавьте в блок `// @match` строку: `// @match        *://ВАШ-ХОСТ/*` и сохраните скрипт.

Скрипт срабатывает при загрузке страницы и при изменении DOM (SPA).

---

## Что делает скрипт

- Ищет ссылки `a[href="/ReferralLinks"]` и `a[href="/SupportMe"]` и удаляет их родительские пункты меню `<li class="nav-item">`.
- Ищет футер `footer.main-footer` и заменяет текст с «Retro Mike Tech» и «All rights reserved» на **public-pool-btc.ru All rights reserved.**

Файл скрипта в репозитории: **scripts/native-webui-public-pool-btc.userscript.js**.
