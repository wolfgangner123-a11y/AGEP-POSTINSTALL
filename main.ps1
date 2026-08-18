# Comprobar privilegios de Administrador y reiniciar con permisos si es necesario
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm '$PSCommandPath' | iex`"" -Verb RunAs
    exit
}

function Mostrar-Menu {
    Clear-Host
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host "         MI HERRAMIENTA TECNICA POST-INSTALL      " -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  [1] Instalar Google Chrome" -ForegroundColor Yellow
    Write-Host "  [2] Instalar WinRAR" -ForegroundColor Yellow
    Write-Host "  [3] Instalar VLC Media Player" -ForegroundColor Yellow
    Write-Host "  [4] Instalar Todo (Chrome, WinRAR, VLC)" -ForegroundColor Green
    Write-Host "  [5] Salir" -ForegroundColor Red
    Write-Host ""
    Write-Host "==================================================" -ForegroundColor Cyan
}

do {
    Mostrar-Menu
    $opcion = Read-Host "Selecciona una opcion [1-5]"

    switch ($opcion) {
        '1' {
            Write-Host "`nInstalando Google Chrome..." -ForegroundColor Cyan
            winget install --id Google.Chrome -e --accept-source-agreements --accept-package-agreements
            Pause
        }
        '2' {
            Write-Host "`nInstalando WinRAR..." -ForegroundColor Cyan
            winget install --id RARLab.WinRAR -e --accept-source-agreements --accept-package-agreements
            Pause
        }
        '3' {
            Write-Host "`nInstalando VLC Media Player..." -ForegroundColor Cyan
            winget install --id VideoLAN.VLC -e --accept-source-agreements --accept-package-agreements
            Pause
        }
        '4' {
            Write-Host "`nInstalando todos los programas..." -ForegroundColor Cyan
            winget install --id Google.Chrome -e --accept-source-agreements --accept-package-agreements
            winget install --id RARLab.WinRAR -e --accept-source-agreements --accept-package-agreements
            winget install --id VideoLAN.VLC -e --accept-source-agreements --accept-package-agreements
            Pause
        }
        '5' {
            Write-Host "`nSaliendo..." -ForegroundColor Gray
        }
        Default {
            Write-Host "`nOpcion no valida. Intenta de nuevo." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
} while ($opcion -ne '5')
