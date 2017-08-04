$arguments = @{
    url         = 'http://download.wsusoffline.net/wsusoffline1101.zip'
    checksum    = '89508EA89CD4B6846D7049085D49C3023D32292AA9F96D415618B399FCCAE8BB'
    destination = $env:AppData
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\UpdateGenerator.exe')
New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\client\UpdateInstaller.exe')
