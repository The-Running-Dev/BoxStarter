$arguments      = @{
    url         = 'https://downloads.nordcdn.com/apps/windows/10/NordVPN/latest/NordVPNSetup.exe'
    checksum    = '52F1CDDB25A964B4474AC461DE8E17EE617703A058971CEAF54B84F4067DA38A'
    silentArgs  = '/quiet /norestart'
}

Install-Package $arguments

# Remove the shortcut on the desktop
Get-ChildItem "$env:Public\Desktop" NordVPN* | Remove-Item

# Remove from Windows startup
Remove-ItemProperty `
    -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' `
    -Name 'NordVPN' -ErrorAction SilentlyContinue
