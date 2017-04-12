$installer          = 'SlackSetup.exe'
$url                = 'https://downloads.slack-edge.com/releases_x64/SlackSetup.exe'
$checksum           = 'EA1D6A7F8EA1B6B18FDFA6387A21AE3F56666C8423AB5E7744C3D4B4337BAF18'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/s'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments
