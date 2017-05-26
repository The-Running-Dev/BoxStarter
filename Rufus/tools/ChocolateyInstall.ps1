$processName        = [System.IO.Path]::GetFileNameWithoutExtension($installer)
$arguments          = @{
    url             = 'https://rufus.akeo.ie/downloads/rufus-2.15.exe'
    checksum        = '13D5D1AA0663F78DB23701CC336956A3E5BC7F7B90981F0B46D4D219C126B498'
    executable      = 'rufus.exe'
    destination     = Join-Path $env:AppData 'Rufus'
}

$shortcutPath = Join-Path $env:AppData 'Microsoft\Windows\Start Menu\Programs\Rufus.lnk'
$shortcutTarget = (Join-Path $arguments.destination $arguments.executable)

Install-WithCopy $arguments
Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $shortcutTarget

Set-Content -Path ("$installer.gui") -Value $null
