$installer          = 'SlackSetup.exe'
$url                = 'https://downloads.slack-edge.com/releases_x64/SlackSetup.exe'
$checksum           = 'ea1d6a7f8ea1b6b18fdfa6387a21ae3f56666c8423ab5e7744c3d4b4337baf18'
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
