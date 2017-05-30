$arguments      = @{
    url         = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2026.4.24%20Offline%20Installer.exe'
    checksum    = 'BD206A5FFA720EE79107EF2CAA27F6B3DD63F08A9D9171B4A672E5EE04636259'
    silentArgs  = '/s'
}

Install-Package $arguments

if (Get-Process -Name 'Dropbox' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'Dropbox'
}
