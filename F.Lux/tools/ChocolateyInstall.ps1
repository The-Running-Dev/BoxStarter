$installer          = 'flux-setup.exe'
$url                = 'https://justgetflux.com/flux-setup.exe'
$checksum           = '2696C35394CA9125098458FC080461B6C841D6D8FD263B40270D21A8823C65B0'
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
