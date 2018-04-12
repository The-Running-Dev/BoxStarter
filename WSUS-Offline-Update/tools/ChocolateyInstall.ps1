$arguments = @{
    url         = 'http://download.wsusoffline.net/wsusoffline1121.zip'
    checksum    = '7196436B36437E6E62AEB34484931EDD0F5ADB9DD3E72E01ECE042FC48A06101'
    destination = $env:AppData
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\UpdateGenerator.exe')
New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\client\UpdateInstaller.exe')
