# Comprobar privilegios de Administrador y reiniciar con permisos si es necesario
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm '$PSCommandPath' | iex`"" -Verb RunAs
    exit
}

function Mostrar-MenuPrincipal {
    Clear-Host
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host "         MI HERRAMIENTA TECNICA POST-INSTALL      " -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  [1] Instalar Navegadores (Chrome / Brave)" -ForegroundColor Yellow
    Write-Host "  [2] Compresor (WinRAR / Activador)" -ForegroundColor Yellow
    Write-Host "  [3] Salir" -ForegroundColor Red
    Write-Host ""
    Write-Host "==================================================" -ForegroundColor Cyan
}

function Submenu-Navegadores {
    do {
        Clear-Host
        Write-Host "==================================================" -ForegroundColor Cyan
        Write-Host "              INSTALAR NAVEGADORES                " -ForegroundColor Cyan
        Write-Host "==================================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "  [1] Google Chrome" -ForegroundColor Yellow
        Write-Host "  [2] Brave Browser" -ForegroundColor Yellow
        Write-Host "  [3] Instalar Ambos" -ForegroundColor Green
        Write-Host "  [4] Volver al Menu Principal" -ForegroundColor Red
        Write-Host ""
        $opcNav = Read-Host "Selecciona una opcion [1-4]"

        switch ($opcNav) {
            '1' {
                Write-Host "`nInstalando Google Chrome..." -ForegroundColor Cyan
                winget install --id Google.Chrome -e --accept-source-agreements --accept-package-agreements
                Pause
            }
            '2' {
                Write-Host "`nInstalando Brave Browser..." -ForegroundColor Cyan
                winget install --id Brave.Brave -e --accept-source-agreements --accept-package-agreements
                Pause
            }
            '3' {
                Write-Host "`nInstalando Chrome y Brave..." -ForegroundColor Cyan
                winget install --id Google.Chrome -e --accept-source-agreements --accept-package-agreements
                winget install --id Brave.Brave -e --accept-source-agreements --accept-package-agreements
                Pause
            }
        }
    } while ($opcNav -ne '4')
}

function Submenu-WinRAR {
    do {
        Clear-Host
        Write-Host "==================================================" -ForegroundColor Cyan
        Write-Host "               COMPRESOR WINRAR                   " -ForegroundColor Cyan
        Write-Host "==================================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "  [1] Instalar WinRAR" -ForegroundColor Yellow
        Write-Host "  [2] Activar WinRAR" -ForegroundColor Yellow
        Write-Host "  [3] Volver al Menu Principal" -ForegroundColor Red
        Write-Host ""
        $opcRar = Read-Host "Selecciona una opcion [1-3]"

        switch ($opcRar) {
            '1' {
                Write-Host "`nInstalando WinRAR..." -ForegroundColor Cyan
                winget install --id RARLab.WinRAR -e --accept-source-agreements --accept-package-agreements
                Pause
            }
            '2' {
                Write-Host "`nActivando WinRAR..." -ForegroundColor Cyan
                $rarPath = "${env:ProgramFiles}\WinRAR"
                if (-not (Test-Path $rarPath)) {
                    $rarPath = "${env:ProgramFiles(x86)}\WinRAR"
                }

                if (Test-Path $rarPath) {
                    $keyContent = @"
RAR registration data
Unlimited Company License
UID=4b84a1e6b0115024765a
6412212250765a4b84a1e6b0115024765a4b84a1e6b0115024765a
4b84a1e6b0115024765a4b84a1e6b0115024765a4b84a1e6b01150
"@
                    Set-Content -Path "$rarPath\rarreg.key" -Value $keyContent
                    Write-Host "WinRAR activado correctamente." -ForegroundColor Green
                } else {
                    Write-Host "WinRAR no esta instalado en el equipo." -ForegroundColor Red
                }
                Pause
            }
        }
    } while ($opcRar -ne '3')
}

do {
    Mostrar-MenuPrincipal
    $opcion = Read-Host "Selecciona una opcion [1-3]"

    switch ($opcion) {
        '1' { Submenu-Navegadores }
        '2' { Submenu-WinRAR }
        '3' { Write-Host "`nSaliendo..." -ForegroundColor Gray }
        Default {
            Write-Host "`nOpcion no valida. Intenta de nuevo." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
} while ($opcion -ne '3')
