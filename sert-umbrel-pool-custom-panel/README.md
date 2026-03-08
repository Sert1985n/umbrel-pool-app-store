# Pool Config (наши монеты) — порт 8563

Отдельная панель: список **всех 28 монет** из `/home/umbrel/.miningcore/coins.json`.

## Если не устанавливается («Something went wrong»)

Приложение использует образ из GitHub Container Registry. Сделайте **один раз**:

1. В репозитории **https://github.com/Sert1985n/umbrel-pool-app-store** откройте вкладку **Actions**.
2. Слева выберите **Build Pool Custom Panel image** → нажмите **Run workflow** → **Run workflow**.
3. Дождитесь зелёной галочки (1–3 минуты).
4. В GitHub: **Your profile** (иконка профиля) → **Packages** → найдите **pool-custom-panel** → откройте → **Package settings** → **Danger Zone** → **Change visibility** → **Public**.
5. В Umbrel снова нажмите **Install** у приложения «Pool Config (наши монеты)».

После этого установка должна пройти. Открыть панель: **http://ВАШ-IP:8563**.
