$arguments      = @{
    url         = 'https://downloads.nordcdn.com/apps/windows/10/NordVPN/latest/NordVPNSetup.exe'
    checksum    = '2C0CAFF0BC1B77C03B1530A6563F3BA3C80A5A8EE6B4D3C7E4A66F0D435D53CA'
    silentArgs  = '/quiet /norestart'
}

Install-Package $arguments
