$arguments          = @{
    url             = 'https://download.spotify.com/SpotifyFullSetup.exe'
    checksum        = 'F3C8624FD023474226D21597BDD503CD377171EB37789829C71EFDC6CF5CD922'
    silentArgs      = '/silent'
}

Install-WithScheduledTask $arguments

$done = $false
do {
    if (Get-Process 'Spotify' -ErrorAction SilentlyContinue) {
        Stop-Process -name 'Spotify'
        $done = $true
    }

    Start-Sleep 10

}
until ($done)

# Remove the shortcut on the desktop
Get-ChildItem "$env:UserProfile\Desktop" Spotify* | Remove-Item

# Remove from Windows startup
Remove-ItemProperty `
    -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' `
    -Name 'Spotify' -ErrorAction SilentlyContinue

Remove-ItemProperty `
    -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' `
    -Name 'Spotify Web Helper' -ErrorAction SilentlyContinue
