$installer          = 'WLAN(v18.40.4).zip'
$url                = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/WLAN/WLAN(v18.40.4).zip'
$checksum           = 'F2D5E50376DFC46FD5FEC062F996AEE12EEC5327CEC1A64D109B1625EFB9ECF9'
$packageChecksum    = '3B740D4939EA6C9B863AA034E53272DBF4A6795F235D9ED1A29EB737A94C403BF707D8C8F056BAA10BB4F90319EFAB6C11F32338065685BD9461C6B5416820A1'
$installerConfig    = Join-Path $packageDir 'Setup.xml'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
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
