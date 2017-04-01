$installer          = 'VPNAreaChameleon.exe'
$url                = 'http://vpnarea.com/VPNAreaChameleon.exe'
$checksum           = '51B2904DA65ACD1FB57C9677CD09D26981C3C7326317FC1D631198E2ABC29AD6'
$installScript      = Join-Path $env:ChocolateyPackageFolder 'Install.exe'
$process            = 'VPNManager'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/S'
    validExitCodes  = @(0, 1641, 3010)
}

# Launch the AutoHotkey script that will confirm the driver warning
Start-Process $installHelper

Install-CustomPackage $arguments

if (Get-Process -Name $process) {
    Stop-Process -processname $process
}
