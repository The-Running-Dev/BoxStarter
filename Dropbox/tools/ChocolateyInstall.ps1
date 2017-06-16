$arguments      = @{
    url         = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2028.4.14%20Offline%20Installer.exe'
    checksum    = 'E15BA04AB0109A082F2ABCEFEF50288BEBAD92F3473093DA3547424867856541'
    silentArgs  = '/s'
}

Install-Package $arguments

if (Get-Process -Name 'Dropbox' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'Dropbox'
}
