$arguments      = @{
    url         = 'https://clientupdates.dropboxstatic.com/dbx-releng/client/Dropbox%2049.4.68%20Offline%20Installer.exe'
    checksum    = '95C78471018B28B39DDE661076D833E64683A0ECDAE469D196460FB8EE478A18'
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
