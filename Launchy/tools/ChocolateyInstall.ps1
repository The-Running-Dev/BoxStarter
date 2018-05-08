$arguments          = @{
    url             = 'http://launchy.net/downloads/win/LaunchySetup2.6B2.exe'
    checksum        = '49E6E7F0FDD9BD16E30D827AC421BD9AFD5DD281577A9B08E8A0C3F91BAD62A1'
    silentArgs      = '/verysilent'
}

# Kill the Launchy process if it's already running
Get-Process -Name Launchy -ErrorAction SilentlyContinue | Stop-Process

Install-Package $arguments
