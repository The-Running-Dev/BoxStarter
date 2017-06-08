$arguments      = @{
    url         = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2027.4.22%20Offline%20Installer.exe'
    checksum    = '6368A0F30E39CB471D9996E631A9DB80FD7A14EC7AB8F2F22F330602AF5D9E59'
    silentArgs  = '/s'
}

Install-Package $arguments

if (Get-Process -Name 'Dropbox' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'Dropbox'
}
