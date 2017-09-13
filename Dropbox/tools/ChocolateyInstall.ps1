$arguments      = @{
    url         = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2034.4.20%20Offline%20Installer.exe'
    checksum    = '9C047DCA4A89B349425B810588D01EB3D497A0051396A4AA6A75E1A5CB3ACE02'
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
