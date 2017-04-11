$installer          = 'node-v7.8.0-x64.msi'
$url                = 'https://nodejs.org/dist/v7.8.0/node-v7.8.0-x64.msi'
$checksum           = 'F66A1774086F31E6E9480F6DD67E31F1853A58D26970A19672B40BA0B318A442'
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