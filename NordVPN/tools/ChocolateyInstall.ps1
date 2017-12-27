$arguments      = @{
    url         = 'https://downloads.nordcdn.com/apps/windows/10/NordVPN/latest/NordVPNSetup.exe'
    checksum    = '29F6D5886B4A2093B8FB330832C465822C2E84810B54751445E26D4B089763D2'
    silentArgs  = '/quiet /norestart'
}

Install-Package $arguments
