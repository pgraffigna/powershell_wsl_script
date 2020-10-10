<# Script para instalar WSL 
 Despues del reinicio instalar desde SO linux desde la Store 
 y continuar por el paso 4
#>

$URL = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"

Write-Output ''
Write-Host "[!!] 1.Instalando Windows Subsystem for linux en el equipo" -ForegroundColor "yellow"
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

Write-Output ''
Write-Host "[!!] 2.Habilitando la caracteristica ++Virtual Machine Platform++" -ForegroundColor "yellow"
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Write-Output ''
Write-Host "[**] 3.El equipo se va a reiniciar para aplicar los cambios [**]" -ForegroundColor "red"
Start-Sleep -Seconds 5
Restart-Computer

Write-Output ''
Write-Host "[!!] 4.Descargando e instalando el kernel linux para windows" -ForegroundColor "yellow"
mkdir C:\temp
Invoke-WebRequest -URI $URL -OutFile "C:\temp\wsl_update_x64.msi"
msiexec /i "C:\temp\wsl_update_x64.msi" 

Write-Output ''
Write-Host "[!!] 5.Configurando WSL 2 como predeterminado" -ForegroundColor "yellow"
Start-Sleep -Seconds 10
wsl --set-default-version 2



