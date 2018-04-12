$arguments      = @{
    url         = 'https://clientupdates.dropboxstatic.com/dbx-releng/client/Dropbox%2047.4.74%20Offline%20Installer.exe'
    checksum    = 'DAE76000012F240C24F95C29FE9E89BFE191014EEE1EBAC395A264F47325C50E'
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
