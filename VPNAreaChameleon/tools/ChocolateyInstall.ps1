$updatedOn = ''
$arguments = @{
    url        = 'https://vpnarea.com/VPNAreaChameleon.exe'
    checksum   = '51B2904DA65ACD1FB57C9677CD09D26981C3C7326317FC1D631198E2ABC29AD6'
    silentArgs = '/S'
}

Install-WithAutoHotKey $arguments

if (Get-Process -Name 'VPNManager' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'VPNManager'
}