$installer          = 'datagrip-2017.1.exe'
$url                = 'https://download.jetbrains.com/datagrip/datagrip-2017.1.exe'
$checksum           = '7360ce2e21a9f8602c9cc5edc281d8ed773cbb05b23ef4bcc1ba930e98b24f23'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/S'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments
