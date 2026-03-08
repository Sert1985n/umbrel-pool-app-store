# Родная MiningCore Web UI — убрать Referral Links, Support Me, свой копирайт

В интерфейсе родной MiningCore Web UI (образ theretromike/miningcorewebui) по умолчанию есть пункты меню **Referral Links** и **Support Me**, а внизу — **Copyright © 2025 Retro Mike Tech All rights reserved.**

Чтобы **удалить** эти надписи и заменить копирайт на **public-pool-btc.ru All rights reserved.**, используйте один из способов ниже.

---

## Вариант 1: Tampermonkey / Violentmonkey

1. Установите расширение браузера **Tampermonkey** ([Chrome](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo)) или **Violentmonkey**.
2. Откройте панель расширения → «Добавить новый скрипт».
3. Вставьте содержимое файла **scripts/native-webui-public-pool-btc.userscript.js** из этого репозитория (или скопируйте его ниже).
4. Сохраните скрипт.
5. Откройте страницу родной MiningCore Web UI (например `http://umbrel.local:8559` или ваш хост/порт). Скрипт сам:
   - удалит пункты меню **Referral Links** и **Support Me**;
   - заменит текст в футере на **Copyright © 2025 public-pool-btc.ru All rights reserved.**

Скрипт по умолчанию запускается на `umbrel.local`, `localhost`, `127.0.0.1`, `*.local`, `192.168.*`. Если родная Web UI открыта по другому адресу, в Tampermonkey добавьте в блок `// @match` строку: `// @match        *://ВАШ-IP/*` и сохраните скрипт.

---

## Вариант 2: Букмарклет (без Tampermonkey)

1. Откройте родную Web UI (например http://192.168.0.244:8559/).
2. Добавьте в закладки браузера новую закладку.
3. В поле «URL» вставьте этот код (одной строкой) и сохраните:

```
javascript:(function(){var c='Copyright © 2025 public-pool-btc.ru All rights reserved.';document.querySelectorAll('a[href="/ReferralLinks"]').forEach(function(a){var li=a.closest('li.nav-item');if(li)li.remove();});document.querySelectorAll('a[href="/SupportMe"]').forEach(function(a){var li=a.closest('li.nav-item');if(li)li.remove();});var f=document.querySelector('footer.main-footer');if(f){var s=f.querySelector('strong');if(s&&/Retro Mike|All rights/i.test(s.textContent))s.textContent=c;}});
```

4. Каждый раз при открытии страницы Pool Configuration или главной Web UI нажимайте эту закладку — пункты Referral Links и Support Me удалятся, копирайт сменится на public-pool-btc.ru.

Скрипт срабатывает при загрузке страницы и при изменении DOM (SPA).

---

## Что делает скрипт

- Ищет ссылки `a[href="/ReferralLinks"]` и `a[href="/SupportMe"]` и удаляет их родительские пункты меню `<li class="nav-item">`.
- Ищет футер `footer.main-footer` и заменяет текст с «Retro Mike Tech» и «All rights reserved» на **public-pool-btc.ru All rights reserved.**

Файл скрипта в репозитории: **scripts/native-webui-public-pool-btc.userscript.js**.
