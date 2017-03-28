$installer          = 'K-Lite_Codec_Pack_1295_Mega.exe'
$url                = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1300_Mega.exe'
$checksum           = '49c08d091c4ce703df5200afa326a7d6f35977dc4ff72a5c9265ddb6e848897a'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = ''
    silentArgs      = '/VERYSILENT'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments
