$arguments      = @{
    url         = 'https://clientupdates.dropboxstatic.com/dbx-releng/client/Dropbox%2063.4.107%20Offline%20Installer.exe'
    checksum    = 'AA21B1738690EAA6DB724466668C247AF97DDB15FB13A48E34185D06DA35D2E3'
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

# Remove the shortcut on the desktop
Get-ChildItem "$env:UserProfile\Desktop" 'Dropbox*' | Remove-Item
