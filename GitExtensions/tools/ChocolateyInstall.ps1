$installer          = 'GitExtensions-2.49.03-SetupComplete.msi'
$url                = 'https://github.com/gitextensions/gitextensions/releases/download/v2.49.03/GitExtensions-2.49.03-SetupComplete.msi'
$checksum           = 'ADE16FB9ECB92538ACFDCC70C377A4BD67EBE954FDCFABD6C6E35F27A96146DB'
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
