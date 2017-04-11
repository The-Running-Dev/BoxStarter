$installer          = 'eav_nt64_enu.exe'
$url                = 'https://download.eset.com/com/eset/apps/home/eav/windows/latest/eav_nt64_enu.exe'
$checksum           = '208F3D1904B89FEE7FCB72A0E877AE3E7D240A8A9F105B1F39B7106C9B11F5A9'
$os                 = if (IsSystem32Bit) { "86" } else { "64" }
$installScript      = Join-Path $env:ChocolateyPackageFolder 'Install.exe'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder "eav_nt$($os)_enu.exe"
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    validExitCodes  = @(0, 1641, 3010)
}

# Launch the AutoHotkey script that install the application
Start-Process $installScript

Install-CustomPackage $arguments
