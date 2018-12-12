$arguments = @{
    url         = 'http://download.wsusoffline.net/wsusoffline115.zip'
    checksum    = 'A44387A301A181843270720FCFD414B50496D9BD3F25E4336086B814B6FB84CB'
    destination = $env:AppData
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\UpdateGenerator.exe')
New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\client\UpdateInstaller.exe')
