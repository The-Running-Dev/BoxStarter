$arguments      = @{
    url         = 'https://downloads.nordcdn.com/apps/windows/10/NordVPN/latest/NordVPNSetup.exe'
    checksum    = '52F1CDDB25A964B4474AC461DE8E17EE617703A058971CEAF54B84F4067DA38A'
    silentArgs  = '/quiet /norestart'
}

Install-Package $arguments
