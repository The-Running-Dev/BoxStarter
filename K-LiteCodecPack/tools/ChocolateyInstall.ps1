$installer          = 'K-Lite_Codec_Pack_1300_Mega.exe'
$url                = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1300_Mega.exe'
$checksum           = '49C08D091C4CE703DF5200AFA326A7D6F35977DC4FF72A5C9265DDB6E848897A'
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
