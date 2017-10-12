$arguments = @{
    url         = 'http://download.wsusoffline.net/wsusoffline1102.zip'
    checksum    = 'B87152A1064A14DC424E283E01330A91075C6F0903442400609B8D04AB8BEB6B'
    destination = $env:AppData
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\UpdateGenerator.exe')
New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\client\UpdateInstaller.exe')
