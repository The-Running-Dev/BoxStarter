$arguments      = @{
    url         = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2033.4.23%20Offline%20Installer.exe'
    checksum    = 'F0CB456EF56C94DA8FD2BC4416CB70329133690B333E60BFD0ABADA8ACD70E7B'
    silentArgs  = '/s'
}

$isUprade = $false

# If the Dropbox process exists
if (Get-Process -Name 'Dropbox' -ErrorAction SilentlyContinue) {
    $isUprade = $true
}

Install-Package $arguments

if (-not $isUprade -and (Get-Process -Name 'Dropbox' -ErrorAction SilentlyContinue)) {
    Stop-Process -processname 'Dropbox'
}
