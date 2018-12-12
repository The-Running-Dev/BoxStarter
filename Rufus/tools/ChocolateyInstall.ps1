$processName        = [System.IO.Path]::GetFileNameWithoutExtension($installer)
$arguments          = @{
    url             = 'https://github.com/pbatard/rufus/releases/download/v3.4/rufus-3.4.exe'
    checksum        = 'FBD6456D0E0EB2184FEDAD9426298407743E2B7D547D3343F76B01B6E568FCB6'
    executable      = 'rufus.exe'
    destination     = Join-Path $env:AppData 'Rufus'
}

$shortcutPath = Join-Path $env:AppData 'Microsoft\Windows\Start Menu\Programs\Rufus.lnk'
$shortcutTarget = (Join-Path $arguments.destination $arguments.executable)

Install-WithCopy $arguments
Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $shortcutTarget

Set-Content -Path ("$installer.gui") -Value $null
