# install.ps1 — установка скилов prokop-skills в каталог навыков Прокопия
# Пример:  .\scripts\install.ps1
#          .\scripts\install.ps1 -Target C:\Users\you\.prokop\skills
#          .\scripts\install.ps1 -WhatIf

param(
    [string]$Target = (Join-Path $env:USERPROFILE ".prokop\skills"),
    [switch]$Force,
    [switch]$WhatIf
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot          # корень репо
$src  = Join-Path $root "skills"

if (-not (Test-Path -LiteralPath $src)) {
    throw "Не найдена папка skills: $src"
}
if (-not $WhatIf) {
    New-Item -ItemType Directory -Path $Target -Force | Out-Null
}

Write-Host "Установка скилов в: $Target"
$count = 0
Get-ChildItem -LiteralPath $src -Directory | ForEach-Object {
    $name = $_.Name
    $dest = Join-Path $Target $name
    if (-not (Test-Path -LiteralPath (Join-Path $_ "SKILL.md"))) {
        Write-Warning "Пропуск $name (нет SKILL.md)"
        return
    }
    if ($WhatIf) {
        Write-Host "  [WhatIf] $name -> $dest"
        $count++
        return
    }
    if (Test-Path -LiteralPath $dest) {
        if (-not $Force) {
            Write-Warning "Каталог уже существует: $dest (используйте -Force для перезаписи)"
            return
        }
        Remove-Item -LiteralPath $dest -Recurse -Force
    }
    Copy-Item -LiteralPath $_ -Destination $dest -Recurse -Force
    Write-Host "  ok  $name -> $dest"
    $count++
}
Write-Host "Готово: $count скил(ов) установлено."
if ($count -eq 0) { Write-Warning "Ничего не установлено." }
