$installer          = 'ITBM_v1.0.0.1027.zip'
$url                = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/Others/ITBM_v1.0.0.1027.zip'
$checksum           = 'F63F64610A842CC4B3BB2D006389C4358E4018492D07AE046626DC745A4C6014'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    executable      = 'ITBM_v1.0.0.1027\ITBM_Setup(v1.0.0.1027).exe'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /NOCLOSEAPPLICATIONS /NORESTARTAPPLICATIONS /NOICONS'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments