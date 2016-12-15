$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'iTunesFusion'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'iTunesFusionSetup-2.6.exe'
  url             = 'https://www.binaryfortress.com/Data/Download/?package=itunesfusion&log=102'
  softwareName    = 'iTunesFusion*'
  checksum        = '2CE11CE6F3C5ED6A6B24D47C9EA346488BA5FA46AE525B31F9ADF7246E06FA1F'
  checksumType    = 'sha256'
  silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments