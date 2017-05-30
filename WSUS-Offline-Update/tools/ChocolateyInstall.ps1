$arguments = @{
    url         = 'http://download.wsusoffline.net/wsusoffline1092.zip'
    checksum    = '80491D0630EC449B16A2744E05C9E0143EC54F86A3FC94F3213C2874D13D3B9F'
    destination = $env:AppData
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\UpdateGenerator.exe')
New-StartMenuShortcut (Join-Path $arguments.destination 'wsusoffline\client\UpdateInstaller.exe')
