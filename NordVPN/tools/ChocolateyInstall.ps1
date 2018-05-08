$arguments      = @{
    url         = 'https://downloads.nordcdn.com/apps/windows/10/NordVPN/latest/NordVPNSetup.exe'
    checksum    = '76D97EF64A86E0CFFC0F0980E50AAF605A9E32125A3FBA2D756930F6A85CB741'
    silentArgs  = '/quiet /norestart'
}

Install-Package $arguments
