@echo off
setlocal

set "api_url=https://api.github.com/repos/FabricioMR22/match-day/releases/latest"

curl -s %api_url% > temp.json

for /f "tokens=*" %%a in ('findstr /r /c:"\"browser_download_url\"" temp.json') do set "download_url=%%a"
set "download_url=%download_url:~24,-1%"

curl -LO %download_url%

powershell -command "Expand-Archive -Path 'match.zip' -DestinationPath '.'"

powershell -command "Get-WmiObject -Class Win32_DiskDrive | Select-Object -ExpandProperty SerialNumber > serial.txt"

del temp.json
del match.zip

endlocal
