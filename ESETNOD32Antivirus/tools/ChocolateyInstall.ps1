$installer          = 'eav_nt64_enu.exe'
$url                = 'https://download.eset.com/com/eset/apps/home/eav/windows/latest/eav_nt64_enu.exe'
$checksum           = '7EA55A484E75BD8968247B950CD2A8F1751AE79CF2E65ADCC5AF8926DE85EB5D'
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
