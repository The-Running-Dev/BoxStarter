$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'Dropbox'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'Dropbox 16.4.30 Offline Installer.exe'
  url             = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2016.4.30%20Offline%20Installer.exe'
  softwareName    = 'Dropbox*'
  checksum        = '2C5AE01F2B722A4154A9FA2E58A07591820BA96532B0662F0FD187B7F77F9261'
  checksumType    = 'sha256'
  silentArgs      = '/s'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments

if (Get-Process -Name Dropbox) {
  Stop-Process -processname Dropbox
}