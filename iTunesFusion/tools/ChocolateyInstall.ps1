$script           = $MyInvocation.MyCommand.Definition
$packageName      = 'iTunesFusion'
$installer        = Join-Path (GetParentDirectory $script) 'iTunesFusionSetup-2.6.exe'
$url              = 'https://www.binaryfortress.com/Data/Download/?package=itunesfusion&log=102'

$packageArgs      = @{
  packageName     = $packageName
  unzipLocation   = (GetCurrentDirectory $script)
  fileType        = 'exe'
  file            = $installer
  url             = $url
  softwareName    = 'iTunesFusion*'
  checksum        = '2CE11CE6F3C5ED6A6B24D47C9EA346488BA5FA46AE525B31F9ADF7246E06FA1F'
  checksumType    = 'sha256'
  silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
  validExitCodes  = @(0, 3010, 1641)
}

Install $packageArgs