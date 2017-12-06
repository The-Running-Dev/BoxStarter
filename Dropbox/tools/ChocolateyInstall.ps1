$arguments      = @{
    url         = 'https://clientupdates.dropboxstatic.com/dbx-releng/client/Dropbox%2040.4.46%20Offline%20Installer.exe'
    checksum    = 'D6586B8C353DFC7A8FF0A577821BAD4C68CFF40565C77AC48E7DE693AA785F84'
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
