# Create missing node app folders. Run from project root.
$ErrorActionPreference = "Stop"
$root = "c:\Users\WIN-10\Desktop\Umbrel-Pool-Project"
$dozzleImage = "amir20/dozzle:v8.12.8@sha256:8ff3115c9c9dd7576839df6f2575de345ca7cafa398cf2496f1f19c31d862ac1"

$nodes = @(
    @{ id="etc";  name="Ethereum Classic (ETC) Node";  rpc=8545;  port=5028 },
    @{ id="ethw"; name="EthereumPoW (ETHW) Node";     rpc=8546;  port=5029 },
    @{ id="zeph"; name="Zephyr (ZEPH) Node";         rpc=38081; port=5030 },
    @{ id="space"; name="Spacecoin (SPACE) Node";    rpc=9133;  port=5031 },
    @{ id="xel";  name="Xelis (XEL) Node";           rpc=8080;  port=5032 },
    @{ id="octa"; name="OctaSpace (OCTA) Node";     rpc=8547;  port=5033 },
    @{ id="zec";  name="Zcash (ZEC) Node";           rpc=8232;  port=5034 },
    @{ id="flux"; name="Flux (FLUX) Node";           rpc=16124; port=5035 },
    @{ id="aur";  name="Auroracoin (AUR) Node";      rpc=9051;  port=5036 },
    @{ id="fch";  name="FCH Node";                   rpc=9052;  port=5037 },
    @{ id="susu"; name="SuSu Node";                  rpc=9053;  port=5038 },
    @{ id="dvt";  name="DVT Node";                   rpc=9054;  port=5039 },
    @{ id="fxtc"; name="FXTC Node";                 rpc=9055;  port=5040 },
    @{ id="smly"; name="Smiley (SMLY) Node";        rpc=9056;  port=5041 },
    @{ id="veil"; name="Veil (VEIL) Node";           rpc=9057;  port=5042 },
    @{ id="marks"; name="Marks (MARKS) Node";       rpc=9058;  port=5043 },
    @{ id="maza"; name="Maza (MAZA) Node";          rpc=9059;  port=5044 },
    @{ id="dgc";  name="DGC Node";                  rpc=9060;  port=5045 },
    @{ id="vls";  name="VLS Node";                   rpc=9061;  port=5046 },
    @{ id="quai"; name="Quai (QUAI) Node";           rpc=9062;  port=5047 },
    @{ id="shnd"; name="SHND Node";                  rpc=9063;  port=5048 },
    @{ id="tit";  name="TIT Node";                  rpc=9064;  port=5049 },
    @{ id="htr";  name="HTR Node";                   rpc=9065;  port=5051 },
    @{ id="chta"; name="CHTA Node";                  rpc=9066;  port=5052 },
    @{ id="xrg";  name="XRG Node";                   rpc=9067;  port=5053 },
    @{ id="plc";  name="PLC Node";                   rpc=9068;  port=5054 },
    @{ id="acg";  name="ACG Node";                   rpc=9069;  port=5055 },
    @{ id="rbl";  name="RBL Node";                   rpc=9070;  port=5056 },
    @{ id="btcp"; name="Bitcoin Private (BTCP) Node"; rpc=9071; port=5057 },
    @{ id="bca";  name="BCA Node";                  rpc=9072;  port=5058 },
    @{ id="plm";  name="PLM Node";                   rpc=9073;  port=5059 },
    @{ id="nito"; name="Nito (NITO) Node";           rpc=9074;  port=5060 },
    @{ id="plhv"; name="PLHV Node";                  rpc=9075;  port=5061 },
    @{ id="btco"; name="BTCO Node";                  rpc=9076;  port=5062 },
    @{ id="lmc";  name="LMC Node";                   rpc=9077;  port=5063 },
    @{ id="bkc";  name="BKC Node";                   rpc=9078;  port=5064 },
    @{ id="nbgo"; name="nBGCO Node";                 rpc=9079;  port=5065 },
    @{ id="kpepe"; name="KPEPE Node";                rpc=9080;  port=5066 },
    @{ id="xbt";  name="XBT Node";                  rpc=9081;  port=5067 },
    @{ id="kwr";  name="KWR Node";                   rpc=9082;  port=5068 },
    @{ id="myt";  name="MYT Node";                   rpc=9083;  port=5069 },
    @{ id="cas";  name="CAS Node";                   rpc=9084;  port=5070 },
    @{ id="fix";  name="FIX Node";                   rpc=9085;  port=5071 },
    @{ id="wjk";  name="WJK Node";                   rpc=9086;  port=5072 },
    @{ id="btcv"; name="BTCV Node";                  rpc=9087;  port=5073 },
    @{ id="rvc";  name="RVC Node";                   rpc=9088;  port=5074 },
    @{ id="xro";  name="XRO Node";                   rpc=9089;  port=5075 },
    @{ id="bblu"; name="BBLU Node";                  rpc=9090;  port=5076 },
    @{ id="oxc";  name="OXC Node";                   rpc=9091;  port=5077 },
    @{ id="vive"; name="VIVE Node";                  rpc=9092;  port=5078 },
    @{ id="hrc";  name="HRC Node";                   rpc=9093;  port=5079 },
    @{ id="aure"; name="AURE Node";                  rpc=9094;  port=5080 },
    @{ id="dmd";  name="DMD Node";                   rpc=9095;  port=5081 }
)

$iconBase = "https://cdn.jsdelivr.net/npm/cryptocurrency-icons@0.18.1/128/color"
foreach ($n in $nodes) {
    $appId = "sert-umbrel-pool-$($n.id)-node"
    $dir = Join-Path $root $appId
    if (Test-Path $dir) { Write-Host "Skip (exists): $appId"; continue }
    New-Item -ItemType Directory -Path $dir -Force | Out-Null

    $iconUrl = "$iconBase/$($n.id).png"
    if ($n.id -eq "etc") { $iconUrl = "https://cryptologos.cc/logos/ethereum-classic-etc-logo.svg" }
    if ($n.id -eq "zec") { $iconUrl = "https://cryptologos.cc/logos/zcash-zec-logo.svg" }
    if ($n.id -eq "flux") { $iconUrl = "https://cryptologos.cc/logos/flux-flux-logo.svg" }
    if ($n.id -eq "aur") { $iconUrl = "https://cryptologos.cc/logos/auroracoin-aur-logo.svg" }

    $yml = @"
manifestVersion: 1
id: $appId
name: $($n.name)
tagline: Нода для пула или соло-майнинга
icon: $iconUrl
category: Mining Nodes
version: "1.0.0"
port: $($n.port)
description: |
  Нода $($n.name -replace ' Node',''). В config.json пула укажите host: ${appId}_node_1, port: $($n.rpc).
  Документация: https://github.com/Sert1985n/umbrel-pool-app-store

developer: Sert1985n
website: https://github.com/Sert1985n/umbrel-pool-app-store
submitter: Sert1985n
submission: https://github.com/Sert1985n/umbrel-pool-app-store
repo: https://github.com/Sert1985n/umbrel-pool-app-store
support: https://github.com/Sert1985n/umbrel-pool-app-store
gallery: []
releaseNotes: RPC $($n.rpc). Замените image на реальный daemon при наличии.
dependencies: []
path: ""
defaultUsername: ""
defaultPassword: ""
"@
    [System.IO.File]::WriteAllText((Join-Path $dir "umbrel-app.yml"), $yml, [System.Text.UTF8Encoding]::new($false))

    $compose = @"
version: "3.7"

services:

  app_proxy:
    environment:
      APP_HOST: ${appId}_web_1
      APP_PORT: 8080
  web:
    image: $dozzleImage
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
    restart: on-failure
    depends_on:
      - node
  node:
    image: alpine:3.18
    restart: on-failure
    command: ["tail", "-f", "/dev/null"]
    volumes:
      - `${APP_DATA_DIR}/.$($n.id):/data
    ports:
      - "$($n.rpc):$($n.rpc)"
"@
    [System.IO.File]::WriteAllText((Join-Path $dir "docker-compose.yml"), $compose, [System.Text.UTF8Encoding]::new($false))
    Write-Host "Created: $appId"
}
Write-Host "Done."
