$arguments = @{
    url         = 'http://download.wsusoffline.net/wsusoffline113.zip'
    checksum    = '75EABB62E3B5A0ECF5A72FBA1CA96CE9D1A1F6494775CDE5CC550EE10C21B46F'
    destination = $env:AppData
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\UpdateGenerator.exe')
New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\client\UpdateInstaller.exe')
