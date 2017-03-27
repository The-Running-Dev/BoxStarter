$installer          = 'GitExtensions-2.49.03-SetupComplete.msi'
$url                = 'https://github.com/gitextensions/gitextensions/releases/download/v2.49.03/GitExtensions-2.49.03-SetupComplete.msi'
$checksum           = ''
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'msi'
    checksumType    = ''
    silentArgs      = '/quiet /norestart'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments