$installer          = 'KDiff3-64bit-Setup_0.9.98-2.exe'
$url                = 'http://downloads.sourceforge.net/project/kdiff3/kdiff3/0.9.98/KDiff3-64bit-Setup_0.9.98-2.exe'
$checksum           = 'D630AB0FDCA3B4F1A85AB7E453F669FDC901CB81BB57F7E20DE64C02AC9A1EEB'
$arguments = @{
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