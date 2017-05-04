$ErrorActionPreference  = 'Stop'
$installScript          = Join-Path $env:ChocolateyPackageFolder 'Install.exe'
$arguments              = @{
    packageName         = $env:ChocolateyPackageName
    softwareName        = 'LTspiceXVII*'
    url                 = 'http://ltspice.linear-tech.com/software/LTspiceXVII.exe'
    checksum            = '7C552AA39ECEC8C5009BDC8EDD9E87154AC5AC680F5D2FF09790793856072429'
    fileType            = 'exe'
    fileFullPath        = Join-Path $env:ChocolateyPackageName 'LTspiceXVII.exe'
    checksumType        = 'sha256'
    validExitCodes      = @(0, 1641, 3010)
}

# Launch the AutoHotkey script that installs the application
Start-Process $installScript

$installer = Get-ChocolateyWebFile @arguments

# Install the package with Chocolatey
Start-Process $installer