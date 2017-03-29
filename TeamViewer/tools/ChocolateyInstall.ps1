$installer          = 'TeamViewer_Setup_en.exe'
$url                = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
$checksum           = 'a99042e54ec68839aa375a2a205baf0dff02160b4a99ce2c887fe5ec7ef69a41'
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

Install-CustomPackage $arguments
