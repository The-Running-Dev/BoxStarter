$arguments = @{
    file           = 'uTorrent.exe'
    url            = 'http://download.ap.bittorrent.com/track/stable/endpoint/utorrent/os/windows'
    checksum       = '52E9AD1773D87EB4A47CF05807D88A603880C42966C468CCC707D8BE76F8B7C6'
    silentArgs     = '/S'
    validExitCodes = @(0, 1)
}

Install-Package $arguments

if (Get-Process 'uTorrent' -ea SilentlyContinue) {
    Stop-Process -name 'uTorrent*' -force
}

Install-BinFile 'uTorrent' (Join-Path (Get-AppInstallLocation $env:ChocolateyPackageTitle) 'uTorrent.exe')
New-StartMenuShortcut (Join-Path (Get-AppInstallLocation $env:ChocolateyPackageTitle) 'uTorrent.exe')
