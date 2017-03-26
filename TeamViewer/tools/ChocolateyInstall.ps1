$installer          = 'TeamViewer_Setup_en.exe'
$url                = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
$checksum           = 'A99042E54EC68839AA375A2A205BAF0DFF02160B4A99CE2C887FE5EC7EF69A41'
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