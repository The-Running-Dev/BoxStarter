$arguments      = @{
    url         = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2029.4.20%20Offline%20Installer.exe'
    checksum    = '8AE54E360B8E6BA7BD0680E62C75A48F942C3B06536431C6947F878EDD3B9935'
    silentArgs  = '/s'
}

Install-Package $arguments

if (Get-Process -Name 'Dropbox' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'Dropbox'
}
