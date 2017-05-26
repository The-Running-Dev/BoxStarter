$arguments      = @{
    url         = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2026.4.23%20Offline%20Installer.exe'
    checksum    = 'C4FDD705FBE5293FAC9BDD084CE4F6E4FB58155F2DC824CFF92735B2DE324C5F'
    silentArgs  = '/s'

}

Install-Package $arguments

if (Get-Process -Name 'Dropbox' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'Dropbox'
}
