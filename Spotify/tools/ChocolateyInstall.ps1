$arguments          = @{
    url             = 'https://download.spotify.com/SpotifyFullSetup.exe'
    checksum        = '2185510752780AAD6079FE129984EC7E5D0BC4F0D82DB786AC88DEAFB3C781C0'
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
