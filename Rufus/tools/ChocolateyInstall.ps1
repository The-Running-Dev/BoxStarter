$processName        = [System.IO.Path]::GetFileNameWithoutExtension($installer)
$arguments          = @{
    url             = 'https://rufus.akeo.ie/downloads/rufus-2.17.exe'
    checksum        = '260FBC40C09D3C175A62B94D9DF1A8C5CCB017A69C8C50BFE9AAEB1DF1F45FF6'
    executable      = 'rufus.exe'
    destination     = Join-Path $env:AppData 'Rufus'
}

$shortcutPath = Join-Path $env:AppData 'Microsoft\Windows\Start Menu\Programs\Rufus.lnk'
$shortcutTarget = (Join-Path $arguments.destination $arguments.executable)

Install-WithCopy $arguments
Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $shortcutTarget

Set-Content -Path ("$installer.gui") -Value $null
