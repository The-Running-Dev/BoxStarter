$processName        = [System.IO.Path]::GetFileNameWithoutExtension($installer)
$arguments          = @{
    file            = 'rufus-2.14.exe'
    url             = 'https://rufus.akeo.ie/downloads/rufus-2.14.exe'
    checksum        = 'C1191E6690CBE5D872C3937A4BD352CBFA5178078D6F31C2BC2DCAB9A20F237C'
    executable      = 'rufus.exe'
    destination     = Join-Path $env:AppData 'Rufus'
}

$shortcutPath = Join-Path $env:AppData 'Microsoft\Windows\Start Menu\Programs\Rufus.lnk'
$shortcutTarget = (Join-Path $arguments.destination $arguments.executable)

Install-WithCopy $arguments
Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $shortcutTarget

Set-Content -Path ("$installer.gui") -Value $null
