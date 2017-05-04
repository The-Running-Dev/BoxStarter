$arguments      = @{
    url         = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2025.4.28%20Offline%20Installer.exe'
    checksum    = 'D5299D285757B53EEF5F548ACCE6EC1F50ED09DCC481BD74638F810E44C29614'
    silentArgs  = '/s'

}

Install-Package $arguments

if (Get-Process -Name 'Dropbox' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'Dropbox'
}
