$arguments      = @{
    url         = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2031.4.25%20Offline%20Installer.exe'
    checksum    = '92CC94147B1AE045CBECFD18997105F4AC8E9AF6B1AF6D239E512237C1F71FDA'
    silentArgs  = '/s'
}

Install-Package $arguments

if (Get-Process -Name 'Dropbox' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'Dropbox'
}
