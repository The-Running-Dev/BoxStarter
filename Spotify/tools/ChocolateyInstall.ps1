$arguments          = @{
    url             = 'https://download.spotify.com/SpotifyFullSetup.exe'
    checksum        = 'F907B9B1783327858914DB34BD11B8FC74815580D87F643654D714CFA24A0B78'
    silentArgs      = '/silent'
}

Install-WithScheduledTask $arguments

$done = $false
do {
    if (Get-Process 'Spotify' -ErrorAction SilentlyContinue) {
        Stop-Process -name 'Spotify'
        $done = $true
    }

    Start-Sleep -s 10

}
until ($done)
