$arguments      = @{
    url         = 'https://clientupdates.dropboxstatic.com/dbx-releng/client/Dropbox%2038.4.27%20Offline%20Installer.exe'
    checksum    = '3510DF9D6DF9E90FD9A6A1E75DC1BB3A38EF0AB54EC07585613BE1FD0BB441F8'
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
