$arguments      = @{
    file        = 'Dropbox 23.4.19 Offline Installer.exe'
    url         = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2023.4.19%20Offline%20Installer.exe'
    checksum    = 'B0EF95B799DE483559FCD40871186A5E0C56C9971B99D17D51BA21DCB22FC8B2'
    silentArgs  = '/s'

}

Install-CustomPackage $arguments

if (Get-Process -Name Dropbox -ErrorAction SilentlyContinue) {
    Stop-Process -processname Dropbox
}
