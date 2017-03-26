$installer          = 'GitExtensions-2.49.01-SetupComplete.msi'
$url                = 'https://github.com/gitextensions/gitextensions/releases/download/v2.49.01/GitExtensions-2.49.01-SetupComplete.msi'
$checksum           = 'B5506F1162712356038C7CDCF65AB220343E6AABD8B0E586C5B78B36345A4B03'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'msi'
    checksumType    = 'sha256'
    silentArgs      = '/quiet /norestart'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments