$updatedOn = '2018.03.29 06:42:54'
$arguments = @{
    url        = 'https://vpnarea.com/VPNAreaChameleon.exe'
    checksum   = 'C3C9DE8DDE7A7C0D54114031664B0A296D4A5881DE49F679A022ADF072978E76'
    silentArgs = '/S'
}

Install-WithAutoHotKey $arguments

if (Get-Process -Name 'VPNManager' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'VPNManager'
}
