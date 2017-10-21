$arguments = @{
    url         = 'http://download.wsusoffline.net/wsusoffline1103.zip'
    checksum    = '65CA37FC44DB59F802A021C313935CD531D90CA2DA8A69B0F97DE3DAD8E04F99'
    destination = $env:AppData
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\UpdateGenerator.exe')
New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\client\UpdateInstaller.exe')
