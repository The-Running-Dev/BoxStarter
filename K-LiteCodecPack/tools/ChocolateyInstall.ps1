$installer          = 'K-Lite_Codec_Pack_1295_Mega.exe'
$url                = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1295_Mega.exe'
$checksum           = '898D1E8AF7765093F17FB8020508CD5CB18377C4DB60E8E226A71D53D8CC82CB'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/VERYSILENT'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments