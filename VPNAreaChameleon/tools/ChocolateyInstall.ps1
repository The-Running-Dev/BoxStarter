$updatedOn = ''
$arguments = @{
    url        = 'https://vpnarea.com/VPNAreaChameleon.exe'
    checksum   = '4BBDB5464AE6EBA6C407F74A61789B31C06D48941A846BB897C56CDAFACA3CEA'
    silentArgs = '/S'
}

Install-WithAutoHotKey $arguments

if (Get-Process -Name 'VPNManager' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'VPNManager'
}
