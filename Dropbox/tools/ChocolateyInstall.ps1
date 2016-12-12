$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'Dropbox'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'Dropbox 15.4.22 Offline Installer.exe'
  url             = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2015.4.22%20Offline%20Installer.exe'
  softwareName    = 'Dropbox*'
  checksum        = '46CC8743A1B9BA3BD36799AFE09F7E9BDDA9B7D1F434B3874494BAC02E1757E8'
  checksumType    = 'sha256'
  silentArgs      = '/s'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $packageArgs

if (Get-Process -Name Dropbox) {
  Stop-Process -processname Dropbox
}