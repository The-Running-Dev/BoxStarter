$installer          = 'node-v7.7.3-x64.msi'
$url                = 'https://nodejs.org/dist/v7.7.3/node-v7.7.3-x64.msi'
$checksum           = '755128B0EDFC619B6655CB2A3DBE704504E8E32B775C63DEF6B0049B3E322AE7'
$arguments = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType         = 'msi'
    checksumType    = 'sha256'
    silentArgs      = '/quiet'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments

$env:Path = "$($env:Path);$(Get-ProgramFilesDirectory)\NodeJS"