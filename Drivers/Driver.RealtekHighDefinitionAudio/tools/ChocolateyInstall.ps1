$installer          = 'Realtek_Audio(v7874).zip'
$url                = 'http://asrock.pc.cdn.bitgravity.com/Drivers/All/Audio/Realtek_Audio(v7874).zip'
$checksum           = 'F2D5E50376DFC46FD5FEC062F996AEE12EEC5327CEC1A64D109B1625EFB9ECF9'
$packageChecksum    = ''
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    executable      = 'Realtek_Audio(v7874)\Setup.exe'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/s /sms'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments