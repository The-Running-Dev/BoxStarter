$installer          = 'gsync_enterprise.msi'
$url                = 'https://dl.google.com/drive/gsync_enterprise.msi'
$checksum           = '0A30C0A5782C063EF42D049C798BEF739B4C0CB7D5FCBBECA965C0B97C9AC941'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'msi'
    checksumType    = 'sha256'
    silentArgs      = '/quiet'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments
