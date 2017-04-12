$installer          = 'node-v7.9.0-x64.msi'
$url                = 'https://nodejs.org/dist/v7.9.0/node-v7.9.0-x64.msi'
$checksum           = '9722D751E9D5DD54E2F4384D4259486971B3F073F6CABD32066668D6ABEF4B17'
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

$env:Path = "$($env:Path);$(Get-ProgramFilesDirectory)\NodeJS"
