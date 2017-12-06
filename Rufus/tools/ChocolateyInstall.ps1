$processName        = [System.IO.Path]::GetFileNameWithoutExtension($installer)
$arguments          = @{
    url             = 'https://rufus.akeo.ie/downloads/rufus-2.18.exe'
    checksum        = 'E82ABD7F2C8F8C866141634A1CE10DA8EBF3C58B68CB2EAA351345777BB3F67C'
    executable      = 'rufus.exe'
    destination     = Join-Path $env:AppData 'Rufus'
}

$shortcutPath = Join-Path $env:AppData 'Microsoft\Windows\Start Menu\Programs\Rufus.lnk'
$shortcutTarget = (Join-Path $arguments.destination $arguments.executable)

Install-WithCopy $arguments
Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $shortcutTarget

Set-Content -Path ("$installer.gui") -Value $null
