$installer          = 'WLAN(v18.40.4).zip'
$url                = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/WLAN/WLAN(v18.40.4).zip'
$checksum           = 'F2D5E50376DFC46FD5FEC062F996AEE12EEC5327CEC1A64D109B1625EFB9ECF9'
$installerConfig    = Join-Path $packageDir 'Setup.xml'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    executable      = 'WLAN(v18.40.4)\Win7Plus\Win64\Install\Setup.exe'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = "-s -norestart -c ""default"" ""$installerConfig"""
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments