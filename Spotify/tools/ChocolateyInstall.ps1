$arguments          = @{
    file            = 'SpotifyFullSetup.exe'
    url             = 'https://download.spotify.com/SpotifyFullSetup.exe'
    checksum        = '041625B142EED7A89708D19DCD9785BD812A0EB9E6D9D4A06697F898B705BD6C'
    silentArgs      = '/silent'
}

Install-WithScheduledTask $arguments

$done = $false
do {
    if (Get-Process Spotify -ErrorAction SilentlyContinue) {
        Stop-Process -name Spotify
        $done = $true
    }

    Start-Sleep -s 10

}
until ($done)
