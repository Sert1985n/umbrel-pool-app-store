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

После обновления в списке должно появиться приложение **«Моя панель — Pool Dashboard»** и иконки с cryptologos.cc (если с устройства есть доступ в интернет до cryptologos.cc).

---

## 2. Referral Links и Support Me не удалены, копирайт не изменился

**Причина:** Страница 8559 отдаётся из Docker-образа. Менять её код в репозитории нельзя — только в браузере скрыть пункты и заменить текст.

**Что сделать (букмарклет, без расширений):**

1. Откройте http://192.168.0.244:8559/
2. Создайте **новую закладку** в браузере.
3. В поле «URL» вставьте **целиком** (одной строкой):

```
javascript:(function(){var c='Copyright © 2025 public-pool-btc.ru All rights reserved.';document.querySelectorAll('a[href="/ReferralLinks"]').forEach(function(a){var li=a.closest('li.nav-item');if(li)li.remove();});document.querySelectorAll('a[href="/SupportMe"]').forEach(function(a){var li=a.closest('li.nav-item');if(li)li.remove();});var f=document.querySelector('footer.main-footer');if(f){var s=f.querySelector('strong');if(s&&/Retro Mike|All rights/i.test(s.textContent))s.textContent=c;}});
```

4. Сохраните закладку (например назовите «Pool fix»).
5. **Каждый раз**, когда открываете страницу Pool Configuration или главную 8559, **нажмите эту закладку**. После нажатия Referral Links и Support Me исчезнут, внизу будет копирайт public-pool-btc.ru.

Подробнее и вариант с Tampermonkey: **guides/NATIVE-WEBUI-CUSTOMIZE.md**.

---

## 3. В списке Pool Configuration нет моих монет

**Причина:** Список монет на странице Pool Configuration берётся из файла **coins.json** на сервере Umbrel. Если там нет шаблонов для ваших монет — их не будет в списке.

**Что сделать:**

1. Положить на сервер **полный coins.json** в `/home/umbrel/.miningcore/coins.json` (например скопировать из CasaOS `Apps/postgres/templates/coins.json` или из репозитория Miningcore).
2. Перезапустить Miningcore:  
   `docker restart sert-umbrel-pool-miningcore_server_1`
3. Открыть http://192.168.0.244:8559/PoolConfiguration и нажать **Refresh Master Coin List**.

Подробнее: **guides/POOL-CONFIGURATION-COINS.md**.

---

## 4. Изменения и GitHub

Да, правки в репозитории **сразу записываются в GitHub**: после правок выполняется commit и push в https://github.com/Sert1985n/umbrel-pool-app-store. Чтобы Umbrel подтянул новые приложения и иконки, нужно **обновить магазин** (п. 1).
