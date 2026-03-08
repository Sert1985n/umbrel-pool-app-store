# Запуск и проверка сборки: порты, Docker-образ Pool Dashboard, docker-compose.
# Запуск из корня проекта: .\build.ps1

$ErrorActionPreference = "Stop"
$root = $PSScriptRoot
$failed = $false

Write-Host "`n=== 1. Validate ports (coins-reference.json) ===" -ForegroundColor Cyan
& "$root\scripts\validate-ports.ps1"
if ($LASTEXITCODE -ne 0) { $failed = $true }

Write-Host "`n=== 2. Docker Compose config (MiningCore, Pool UI) ===" -ForegroundColor Cyan
$composeFiles = @(
    "$root\sert-umbrel-pool-miningcore\docker-compose.yml",
    "$root\sert-umbrel-pool-poolui\docker-compose.yml",
    "$root\sert-umbrel-pool-miningcore-webui\docker-compose.yml"
)
foreach ($f in $composeFiles) {
    if (Test-Path $f) {
        if (Get-Command docker -ErrorAction SilentlyContinue) {
            docker compose -f $f config 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) {
                Write-Host "  OK: $(Split-Path $f -Leaf)" -ForegroundColor Green
            } else {
                Write-Host "  FAIL: $(Split-Path $f -Leaf)" -ForegroundColor Red
                $failed = $true
            }
        } else {
            Write-Host "  Docker not in PATH, skip compose check" -ForegroundColor Yellow
        }
    }
}

Write-Host "`n=== 3. Build Pool Dashboard image ===" -ForegroundColor Cyan
if (Get-Command docker -ErrorAction SilentlyContinue) {
    docker build -t pool-dashboard:build-test "$root\sert-umbrel-pool-poolui"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  OK: image pool-dashboard:build-test built" -ForegroundColor Green
    } else {
        Write-Host "  FAIL: image build failed" -ForegroundColor Red
        $failed = $true
    }
} else {
    Write-Host "  Docker not in PATH. Run: docker build -t pool-dashboard:build-test .\sert-umbrel-pool-poolui" -ForegroundColor Yellow
}

Write-Host ""
if ($failed) {
    Write-Host "Build check finished with errors." -ForegroundColor Red
    exit 1
}
Write-Host "All checks passed." -ForegroundColor Green
exit 0
