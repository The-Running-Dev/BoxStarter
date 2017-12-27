$arguments = @{
    url         = 'http://download.wsusoffline.net/wsusoffline111.zip'
    checksum    = '27E1F1D0CCDE68F48D2BA273C80878B4CFAE79DDEC069EA6CAFE9043C166FF6D'
    destination = $env:AppData
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\UpdateGenerator.exe')
New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\client\UpdateInstaller.exe')
