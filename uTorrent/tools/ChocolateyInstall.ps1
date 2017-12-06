$arguments = @{
    file           = 'uTorrent.exe'
    url            = 'http://download.ap.bittorrent.com/track/stable/endpoint/utorrent/os/windows'
    checksum       = '14082C0E0E4DD6C89FE64B7F97049F6C87FF20E457C06170BF0BF230C7D84AB9'
    silentArgs     = '/S'
    validExitCodes = @(0, 1)
}

Install-Package $arguments

if (Get-Process 'uTorrent' -ea SilentlyContinue) {
    Stop-Process -name 'uTorrent*' -force
}

Install-BinFile 'uTorrent' (Join-Path (Get-AppInstallLocation $env:ChocolateyPackageTitle) 'uTorrent.exe')
New-StartMenuShortcut (Join-Path (Get-AppInstallLocation $env:ChocolateyPackageTitle) 'uTorrent.exe')
