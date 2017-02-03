$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'Dropbox'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'Dropbox 19.4.12 Offline Installer'
  url             = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2019.4.12%20Offline%20Installer.exe'
  softwareName    = 'Dropbox*'
  checksum        = '60849E96BE14B393B962E4C20180B348270EFA8C8B0A41BE8F3C2FD2423E73DB'
  checksumType    = 'sha256'
  silentArgs      = '/s'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments

if (Get-Process -Name Dropbox) {
  Stop-Process -processname Dropbox
}