$arguments = @{
    file       = 'Microsoft-VisualCRedistributable2013_x86.exe'
    url        = 'https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe'
    checksum   = '89F4E593EA5541D1C53F983923124F9FD061A1C0C967339109E375C661573C17'
    silentArgs = '/Q /norestart'
}

Install-Package $arguments

$arguments = @{
    file       = 'Microsoft-VisualCRedistributable2013_x86.exe'
    url        = 'https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe'
    checksum   = '89F4E593EA5541D1C53F983923124F9FD061A1C0C967339109E375C661573C17'
    silentArgs = '/Q /norestart'
}

Install-Package $arguments
