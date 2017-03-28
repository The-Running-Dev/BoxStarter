$installer          = 'lastappinstall_x64.exe'
$url                = 'https://lastpass.com/download/cdn/lastappinstall_x64.exe'
$checksum           = '29cb9f2e69cfed90dcefbec8a13615ba7db9c1b74ae6effad1d0e0a078a30bb9'
$installerScript    = Join-Path $packageDir 'Install.exe'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = ''
    silentArgs      = '-si'
    validExitCodes  = @(0, 1641, 3010)
}

# Launch the AutoHotkey script that install the application
Start-Process $installerScript

Install-CustomPackage $arguments
