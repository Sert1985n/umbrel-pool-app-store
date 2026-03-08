# Изменения в poolui и как обновить панель в Umbrel

## Что это за папка

**C:\Users\WIN-10\Desktop\www\poolui** — исходники вашей панели пула (Pool Dashboard). В магазине Umbrel Pool приложение **«MiningCore Web UI»** отдаёт именно эти файлы (их копия лежит в репозитории в `sert-umbrel-pool-miningcore-webui/www`).

## Что можно менять здесь

| Файл | Назначение |
|------|------------|
| **index.html** | Разметка: шапка, логотип, навигация (Home, язык, тема). |
| **app.js** | Логика: запросы к API пула, таблица пулов, страница монеты, блоки статистики, Your Wallet, графики. |
| **site.css** | Стили: цвета, сетка, отступы. |
| **dashboard.css** | Доп. стили, если используются. |
| **pool-meta.json** | Метаданные пула, если нужны. |

После любых правок нужно обновить репозиторий, иначе на Umbrel останется старая версия.

## Как обновить панель на Umbrel после правок

1. Скопируйте изменённые файлы из этой папки (`Desktop\www\poolui`) в папку проекта:
   ```
   …\Umbrel-Pool-Project\sert-umbrel-pool-miningcore-webui\www\
   ```
   (замените изменённые: index.html, app.js, site.css и т.д.)

2. В папке Umbrel-Pool-Project выполните:
   ```
   git add sert-umbrel-pool-miningcore-webui/www
   git commit -m "poolui: описание изменений"
   git push
   ```

3. В Umbrel: откройте магазин Umbrel Pool → **Update** / **Refresh**. Если приложение «MiningCore Web UI» уже установлено, может понадобиться его переустановить или перезапустить, чтобы подтянуть новые файлы.

## Referral Links / Support Me / копирайт

В **этой** панели (poolui) таких блоков нет — это ваш интерфейс.  
Они есть только в **родном** Web UI (приложение «Pool Configuration», порт 8560). Там их убирают в браузере по инструкции: в репозитории см. **guides/NATIVE-WEBUI-CUSTOMIZE.md** (userscript или букмарклет).

## Полная инструкция по проекту

В репозитории: **guides/POOLUI-ИЗМЕНЕНИЯ.md**.
