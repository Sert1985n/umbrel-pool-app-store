#!/usr/bin/env node
/**
 * Проверка coins-reference.json: нет дубликатов stratum и rpcPort.
 * Запуск: node scripts/validate-ports.js
 * Из корня проекта: node scripts/validate-ports.js
 */

const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..');
const file = path.join(root, 'coins-reference.json');

if (!fs.existsSync(file)) {
  console.error('coins-reference.json не найден:', file);
  process.exit(1);
}

let data;
try {
  data = JSON.parse(fs.readFileSync(file, 'utf8'));
} catch (e) {
  console.error('Ошибка парсинга JSON:', e.message);
  process.exit(1);
}

const coins = data.coins;
if (!Array.isArray(coins)) {
  console.error('В файле нет массива coins');
  process.exit(1);
}

const byStratum = new Map();
const byRpc = new Map();
const errors = [];

for (const c of coins) {
  const id = c.id || '?';
  const s = c.stratum;
  const r = c.rpcPort;
  if (s != null) {
    if (byStratum.has(s)) errors.push(`Дубликат stratum ${s}: ${byStratum.get(s)} и ${id}`);
    else byStratum.set(s, id);
  }
  if (r != null) {
    if (byRpc.has(r)) errors.push(`Дубликат rpcPort ${r}: ${byRpc.get(r)} и ${id}`);
    else byRpc.set(r, id);
  }
}

if (errors.length) {
  errors.forEach((e) => console.error(e));
  process.exit(1);
}

console.log('OK: порты без конфликтов, монет:', coins.length);
process.exit(0);
