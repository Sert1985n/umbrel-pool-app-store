# Публикация проекта на GitHub

## 1. Настройка Git (один раз, если ещё не настроено)

```bash
git config --global user.name "Ваше Имя или Логин GitHub"
git config --global user.email "ваш@email.com"
```

## 2. Создать репозиторий на GitHub

1. Откройте [github.com/new](https://github.com/new).
2. Укажите имя репозитория, например: **umbrel-pool-project** или **umbrel-miningcore-setup**.
3. Выберите Public, **не** добавляйте README, .gitignore и лицензию (они уже есть в проекте).
4. Нажмите **Create repository**.

## 3. Первый коммит (если ещё не сделан)

В папке проекта:

```bash
cd c:\Users\WIN-10\Desktop\Umbrel-Pool-Project
git add .
git commit -m "Initial commit: Umbrel pool project docs and coins reference"
```

## 4. Привязать удалённый репозиторий и отправить код

Подставьте вместо `ВАШ_ЛОГИН` и `ИМЯ_РЕПОЗИТОРИЯ` свои значения (например `myname` и `umbrel-pool-project`):

```bash
git remote add origin https://github.com/ВАШ_ЛОГИН/ИМЯ_РЕПОЗИТОРИЯ.git
git branch -M main
git push -u origin main
```

При первом push GitHub может попросить войти (логин и пароль или токен).

## 5. Дальнейшие обновления

После изменений в проекте:

```bash
git add .
git commit -m "Описание изменений"
git push
```
