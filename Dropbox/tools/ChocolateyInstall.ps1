$arguments      = @{
    file        = 'Dropbox 24.4.16 Offline Installer.exe'
    url         = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2024.4.16%20Offline%20Installer.exe'
    checksum    = '314938406172646F961BE0A511120786DA30719B32B3F50211CEBA40C8E712ED'
    silentArgs  = '/s'

}

Install-Package $arguments

if (Get-Process -Name 'Dropbox' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'Dropbox'
}
