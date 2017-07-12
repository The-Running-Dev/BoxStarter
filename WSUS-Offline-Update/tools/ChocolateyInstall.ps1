$arguments = @{
    url         = 'http://download.wsusoffline.net/wsusoffline110.zip'
    checksum    = '97ED0CE55FFE4A226A7A0798C89F2A07ABFF32C1F966ADD20006AB30E19C3378'
    destination = $env:AppData
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\UpdateGenerator.exe')
New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\client\UpdateInstaller.exe')
