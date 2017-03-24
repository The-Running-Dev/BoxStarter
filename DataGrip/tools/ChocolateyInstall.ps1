$installer          = 'datagrip-2016.3.4.exe'
$url                = 'https://download.jetbrains.com/datagrip/datagrip-2016.3.4.exe'
$checksum           = 'a44e3067f69c6b3322bd4b5b27940db1c17a2a536ce95c96981a0cfb9cb97179'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/S'
    validExitCodes  = @(0, 1641, 3010)
}

Install-LocalOrRemote $arguments