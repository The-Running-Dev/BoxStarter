$installer          = 'LaunchySetup2.6B2.exe'
$url                = 'http://launchy.net/downloads/win/LaunchySetup2.6B2.exe'
$checksum           = '49E6E7F0FDD9BD16E30D827AC421BD9AFD5DD281577A9B08E8A0C3F91BAD62A1'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/verysilent'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments