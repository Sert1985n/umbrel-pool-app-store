# Очистка репозитория на GitHub (Releases, Packages)

Чтобы проект был чистым, лишние **Releases** и **Packages** на GitHub можно удалить вручную.

## Releases

1. Откройте https://github.com/Sert1985n/umbrel-pool-app-store/releases
2. Для каждого лишнего релиза нажмите **Delete this release** (и при необходимости удалите тег).
3. Оставьте только нужные релизы или не создавайте релизы — для Umbrel community store они не обязательны.

## Packages (GHCR)

1. Откройте https://github.com/orgs/Sert1985n/packages (или профиль → Packages).
2. Найдите пакет **pool-dashboard** (образ для Pool Dashboard).
3. **Не удаляйте** `ghcr.io/sert1985n/pool-dashboard` — он нужен для установки приложения в Umbrel.
4. Остальные пакеты (если есть старые/тестовые) можно удалить: Package → Package settings → Delete this package.

## Что оставить

- **Код** — все папки приложений, `coins-reference.json`, скрипты, документация.
- **Пакет** `ghcr.io/sert1985n/pool-dashboard` — для приложения Pool Dashboard (моя панель).
- Релизы для этого магазина не обязательны; версии приложений задаются в `umbrel-app.yml` и `umbrel-app-store.yml`.

## Пуш изменений в GitHub

Из корня проекта (после всех правок):

```powershell
git add -A
git status
git commit -m "Иконки: MiningCore logo, Miningcore Web UI webui.png, Pool Dashboard своя иконка; переименование в Miningcore Web UI"
git push origin main
```

Если ветка по умолчанию — `master`, замените `main` на `master`.
