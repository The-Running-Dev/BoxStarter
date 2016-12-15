$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'LogFusion'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'LogFusionSetup-5.1.exe'
  url             = 'https://www.binaryfortress.com/Data/Download/?package=logfusion&log=117'
  softwareName    = 'LogFusion*'
  checksum        = 'C490053837EA7B3661A0B75C30229EEB1D6FA62C41BE4F275892642E27C9690E'
  checksumType    = 'sha256'
  silentArgs      = '/VERYSILENT /LAUNCHAFTER=0 /MERGETASKS=`"!desktopicon,!desktopicon\common,!desktopicon\user`"'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments