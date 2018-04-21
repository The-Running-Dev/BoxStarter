$arguments = @{
    url         = 'http://download.wsusoffline.net/wsusoffline1122.zip'
    checksum    = 'BAD4558C30FCC1D48B538E656EBC8EC99A8EBF32B5436E9F3CD402F71AF89FCC'
    destination = $env:AppData
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\UpdateGenerator.exe')
New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\client\UpdateInstaller.exe')
