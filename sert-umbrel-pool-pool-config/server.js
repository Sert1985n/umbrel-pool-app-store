const express = require('express');
const path = require('path');
const fs = require('fs');

const app = express();
const COINS_FILE = process.env.COINS_FILE || '/app/miningcore/coins.json';
const PORT = 8080;

const OUR_COIN_IDS = [
  'bitcoin', 'bitcoin-cash', 'bitcoin-ii', 'bitcoin-sv', 'bitcoin-silver',
  'digibyte-sha256', 'dogecoin', 'ecash', 'neurai', 'peercoin', 'ravencoin',
  'vertcoin', 'litecoin', 'groestlcoin', 'fractalbitcoin-sha', 'monero', 'ergo',
  'ethereumclassic', 'ethereumpow', 'zephyr', 'spacecoin', 'xelis', 'octaspace',
  'zcash', 'horizen', 'flux', 'firo', 'kaspa', 'nexa'
];

app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

app.get('/health', (req, res) => { res.status(200).send('ok'); });

app.get('/api/coins', (req, res) => {
  try {
    if (!fs.existsSync(COINS_FILE)) {
      return res.json({ coins: [], message: 'coins.json не найден. Скопируйте в /home/umbrel/.miningcore/ и нажмите Refresh.' });
    }
    const raw = fs.readFileSync(COINS_FILE, 'utf8');
    const data = JSON.parse(raw);
    const list = Object.entries(data)
      .filter(([id]) => OUR_COIN_IDS.includes(id))
      .map(([id, c]) => ({ id, name: c.name || id, symbol: (c.symbol || '').toUpperCase() }));
    res.json({ coins: list });
  } catch (e) {
    res.json({ coins: [], error: String(e.message) });
  }
});

app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, '0.0.0.0', () => console.log('Pool Config (мои монеты) on', PORT));
