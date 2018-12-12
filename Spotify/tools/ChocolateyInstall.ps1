$arguments          = @{
    url             = 'https://download.spotify.com/SpotifyFullSetup.exe'
    checksum        = 'AD27A934F870D9E4337AC07BB1F61DB279E424E1AE4D9B2445D0180D89CECD68'
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

# Remove the shortcut on the desktop
Get-ChildItem "$env:UserProfile\Desktop" Spotify* | Remove-Item
