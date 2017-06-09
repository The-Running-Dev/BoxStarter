$arguments = @{
    file           = 'uTorrent.exe'
    url            = 'http://download.ap.bittorrent.com/track/stable/endpoint/utorrent/os/windows'
    checksum       = '154442D57D5F785C73A20EFC3F83CE95C87DE46AD057EB8F386C6A451028C34E'
    silentArgs     = '/S'
    validExitCodes = @(0, 1)
}

Install-Package $arguments

if (Get-Process 'uTorrent' -ea SilentlyContinue) {
    Stop-Process -name 'uTorrent*' -force
}
