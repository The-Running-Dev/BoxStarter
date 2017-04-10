$installer          = 'WebStorm-2017.1.exe'
$url                = 'https://download.jetbrains.com/webstorm/WebStorm-2017.1.exe'
$checksum           = '9A3F7A8CE59A4183D6A75470BC17624240E1D5A88C97DF39233CE5462A0BD5E7'
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
