$installScript      = Join-Path $env:ChocolateyPackageFolder 'Install.exe'
$process            = 'VPNManager'
$arguments          = @{
    file            = 'VPNAreaChameleon.exe'
    url             = 'https://vpnarea.com/VPNAreaChameleon.exe'
    checksum        = '51B2904DA65ACD1FB57C9677CD09D26981C3C7326317FC1D631198E2ABC29AD6'
    silentArgs      = '/S'
    validExitCodes  = @(0, 1641, 3010)
}

# Launch the AutoHotkey script that will confirm the driver warning
Start-Process $installHelper

Install-CustomPackage $arguments

if (Get-Process -Name $process) {
    Stop-Process -processname $process
}
