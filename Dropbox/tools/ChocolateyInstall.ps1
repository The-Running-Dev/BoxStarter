$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'Dropbox'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'Dropbox 16.4.29 Offline Installer.exe'
  url             = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2016.4.29%20Offline%20Installer.exe'
  softwareName    = 'Dropbox*'
  checksum        = '98B23B9EB644361EA75F82F0F9D43502C43D6902AB6352A1DB1F916304C43241'
  checksumType    = 'sha256'
  silentArgs      = '/s'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $packageArgs

if (Get-Process -Name Dropbox) {
  Stop-Process -processname Dropbox
}