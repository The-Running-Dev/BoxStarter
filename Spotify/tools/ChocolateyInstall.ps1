$arguments          = @{
    url             = 'https://download.spotify.com/SpotifyFullSetup.exe'
    checksum        = '2542299A34D7D65414F528901FB1952870282FB7D0F1A065D215AB5233328EA5'
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
