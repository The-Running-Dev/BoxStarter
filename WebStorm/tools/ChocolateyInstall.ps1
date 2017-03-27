$installer          = 'WebStorm-2017.1.exe'
$url                = 'https://download.jetbrains.com/webstorm/WebStorm-2017.1.exe'
$checksum           = '9a3f7a8ce59a4183d6a75470bc17624240e1d5a88c97df39233ce5462a0bd5e7'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
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
