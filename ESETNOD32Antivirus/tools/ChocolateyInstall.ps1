$installScript      = Join-Path $env:ChocolateyPackageFolder 'Install.exe'
$arguments          = @{
    file            = 'eav_nt64_enu.exe'
    url             = 'https://download.eset.com/com/eset/apps/home/eav/windows/latest/eav_nt64_enu.exe'
    checksum        = '7EA55A484E75BD8968247B950CD2A8F1751AE79CF2E65ADCC5AF8926DE85EB5D'
}

# Launch the AutoHotkey script that install the application
Start-Process $installScript

Install-CustomPackage $arguments
