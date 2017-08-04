$processName        = [System.IO.Path]::GetFileNameWithoutExtension($installer)
$arguments          = @{
    url             = 'https://rufus.akeo.ie/downloads/rufus-2.16.exe'
    checksum        = 'DED51BB9C9F99CC2F688F541E77A01C6CE785D3F6A10DBE15B894BCDB05FE6A7'
    executable      = 'rufus.exe'
    destination     = Join-Path $env:AppData 'Rufus'
}

$shortcutPath = Join-Path $env:AppData 'Microsoft\Windows\Start Menu\Programs\Rufus.lnk'
$shortcutTarget = (Join-Path $arguments.destination $arguments.executable)

Install-WithCopy $arguments
Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $shortcutTarget

Set-Content -Path ("$installer.gui") -Value $null
