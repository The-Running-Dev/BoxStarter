$installer          = 'Intel_Bluetooth(v19.10).zip'
$url                = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/Bluetooteh/Intel_Bluetooth(v19.10).zip'
$checksum           = 'D72E1E6AAD4F2CA947A443838CCF415580912EC13577E6257F1038CA35D2323D'
$packageChecksum    = '50A419BB642B6F3C2ACE008F7600DD60EBFC0DFF0CAED26DE8E1B24164D71B40D72E1E6AAD4F2CA947A443838CCF415580912EC13577E6257F1038CA35D2323D'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
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
