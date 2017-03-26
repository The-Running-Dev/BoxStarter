$installer          = 'Intel_Bluetooth(v19.10).zip'
$url                = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/Bluetooteh/Intel_Bluetooth(v19.10).zip'
$checksum           = 'D72E1E6AAD4F2CA947A443838CCF415580912EC13577E6257F1038CA35D2323D'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    executable      = 'Intel_Bluetooth(v19.10)\INF_INSTALL\Win10\x64\dpinst.exe'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/q /se /sa /sw'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments