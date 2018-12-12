$arguments = @{
    file           = 'uTorrent.exe'
    url            = 'http://download.ap.bittorrent.com/track/stable/endpoint/utorrent/os/windows'
    checksum       = '28A6221C9CF6CA14DA87B8A8716831CD5931CE617541D9FE8012417995EA13A9'
    silentArgs     = '/S'
    validExitCodes = @(0, 1)
}

Install-Package $arguments

if (Get-Process 'uTorrent' -ea SilentlyContinue) {
    Stop-Process -name 'uTorrent*' -force
}

Install-BinFile 'uTorrent' (Join-Path (Get-AppInstallLocation $env:ChocolateyPackageTitle) 'uTorrent.exe')
New-StartMenuShortcut (Join-Path (Get-AppInstallLocation $env:ChocolateyPackageTitle) 'uTorrent.exe')
