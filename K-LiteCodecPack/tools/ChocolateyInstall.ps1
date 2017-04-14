$installer          = 'K-Lite_Codec_Pack_1310_Mega.exe'
$url                = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1310_Mega.exe'
$checksum           = 'E1E71AB87AAC18976B41B3AEF2BFA35F4D45550B937E9A5A03BD208CCFB29EAC'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
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
