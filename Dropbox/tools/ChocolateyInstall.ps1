$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'Dropbox'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'Dropbox 17.4.34 Offline Installer.exe'
  url             = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2017.4.34%20Offline%20Installer.exe'
  softwareName    = 'Dropbox*'
  checksum        = 'CCE50F8872FF80711F799F9C92A8DC6A5316A72EF44C6388A84455767C92D351'
  checksumType    = 'sha256'
  silentArgs      = '/s'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments

if (Get-Process -Name Dropbox) {
  Stop-Process -processname Dropbox
}