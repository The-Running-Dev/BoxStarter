$arguments      = @{
    url         = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2030.4.23%20Offline%20Installer.exe'
    checksum    = '0DEAF5D03E4E284D3E5092367DDA7C6614AB83FEAEE05F5F7BAD21AE86B2461C'
    silentArgs  = '/s'
}

Install-Package $arguments

if (Get-Process -Name 'Dropbox' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'Dropbox'
}
