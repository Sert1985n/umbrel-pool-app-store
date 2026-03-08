# Pool Config (наши монеты) — порт 8563

Отдельная панель: список **всех 28 монет** из `/home/umbrel/.miningcore/coins.json`.

## Если не устанавливается («Something went wrong» или падает на 99%)

**Сначала:** на Umbrel должен существовать каталог `/home/umbrel/.miningcore` (он появляется после установки MiningCore). Если MiningCore ещё не ставили, по SSH выполните один раз:
```bash
mkdir -p /home/umbrel/.miningcore
```
Или сначала установите **MiningCore**, затем «Pool Config (наши монеты)».

**Затем** образ из GitHub Container Registry:

1. В репозитории **https://github.com/Sert1985n/umbrel-pool-app-store** → вкладка **Actions**.
2. **Build Pool Custom Panel image** → **Run workflow** → дождитесь зелёной галочки (1–3 мин).
3. **Your profile** → **Packages** → **pool-custom-panel** → **Package settings** → **Change visibility** → **Public**.
4. В Umbrel снова нажмите **Install**.

Открыть панель: **http://ВАШ-IP:8563**.
