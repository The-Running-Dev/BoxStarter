$installer          = 'SlackSetup.exe'
$url                = 'https://slack.com/ssb/download-win64'
$checksum           = '93550137712F4D5E6D6F5E0ED17F5AE2DA561CDC8A2A43FE64F64024B14F01E8'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
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