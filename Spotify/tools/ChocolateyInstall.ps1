$arguments          = @{
    url             = 'https://download.spotify.com/SpotifyFullSetup.exe'
    checksum        = 'E289B203B3D9982F3BC24F7D8F8C2725AF0DCDF2E58F4197639D745A041EC921'
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
