const http = require('http');
const { exec } = require('child_process');

const CONTAINER = process.env.MININGCORE_CONTAINER || 'sert-umbrel-pool-miningcore_server_1';
const PORT = 8081;

const server = http.createServer((req, res) => {
  const url = req.url.split('?')[0];
  if (req.method === 'POST' && (url === '/restart' || url === '/restart-miningcore')) {
    exec(`docker restart ${CONTAINER}`, (err, stdout, stderr) => {
      res.writeHead(200, { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' });
      if (err) {
        res.end(JSON.stringify({ ok: false, error: String(err) }));
        return;
      }
      res.end(JSON.stringify({ ok: true, message: 'MiningCore restart sent' }));
    });
    return;
  }
  if (req.method === 'OPTIONS') {
    res.writeHead(204, { 'Access-Control-Allow-Origin': '*', 'Access-Control-Allow-Methods': 'POST, OPTIONS' });
    res.end();
    return;
  }
  res.writeHead(404);
  res.end();
});

server.listen(PORT, '0.0.0.0', () => console.log(`Restart helper on ${PORT}, container: ${CONTAINER}`));
