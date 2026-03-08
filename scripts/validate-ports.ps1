# Validate coins-reference.json: no duplicate stratum/rpcPort
# Run from repo root: .\scripts\validate-ports.ps1

$ErrorActionPreference = "Stop"
$root = Split-Path $PSScriptRoot -Parent
$file = Join-Path $root "coins-reference.json"

if (-not (Test-Path $file)) {
    Write-Error "coins-reference.json not found: $file"
    exit 1
}

$json = Get-Content $file -Raw -Encoding UTF8 | ConvertFrom-Json
$coins = $json.coins
if (-not $coins) {
    Write-Error "No coins array in file"
    exit 1
}

$byStratum = @{}
$byRpc = @{}
$errs = @()

foreach ($c in $coins) {
    $id = if ($c.id) { $c.id } else { "?" }
    if ($null -ne $c.stratum) {
        if ($byStratum.ContainsKey($c.stratum)) {
            $errs += "Duplicate stratum $($c.stratum): $($byStratum[$c.stratum]) and $id"
        } else {
            $byStratum[$c.stratum] = $id
        }
    }
    if ($null -ne $c.rpcPort) {
        if ($byRpc.ContainsKey($c.rpcPort)) {
            $errs += "Duplicate rpcPort $($c.rpcPort): $($byRpc[$c.rpcPort]) and $id"
        } else {
            $byRpc[$c.rpcPort] = $id
        }
    }
}

if ($errs.Count -gt 0) {
    $errs | ForEach-Object { Write-Host $_ -ForegroundColor Red }
    exit 1
}

$cnt = $coins.Count
Write-Host "OK: ports valid, coins: $cnt" -ForegroundColor Green
exit 0
