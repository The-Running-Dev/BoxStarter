$installer          = 'node-v7.7.4-x64.msi'
$url                = 'https://nodejs.org/dist/v7.7.4/node-v7.7.4-x64.msi'
$checksum           = '55738BB03D48318FE505847EB4675DEBE8BF90ADB1A572AD018B10702EA40819'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
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
