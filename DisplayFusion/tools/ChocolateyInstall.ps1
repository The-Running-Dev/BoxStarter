$script           = $MyInvocation.MyCommand.Definition
$installPath      = Join-Path (GetProgramFilesDirectory) 'DisplayFusion'
$localeTwoLetter  = (Get-Culture).TwoLetterISOLanguageName
$packageArgs      = @{
  packageName     = 'DisplayFusion'
  unzipLocation   = (GetCurrentDirectory $script)
  file            = Join-Path (GetParentDirectory $script) 'DisplayFusionSetup-8.1.1.exe'
  fileType        = 'exe'
  url             = 'https://www.binaryfortress.com/Data/Download/?package=displayfusion&log=101'
  softwareName    = 'DisplayFusion*'
  checksum        = '4E1BE4C25D77E3A8B93F63165E47CD31C6253149D3C1F6D2EF4DE7DD6586A953'
  checksumType    = 'sha256'
  silentArgs      = "/VERYSILENT /LANG=$localeTwoLetter /DIR=`"$installPath`" /STARTUPALL=1 /CONTEXTMENU=0 /LAUNCHAFTER=0 /MERGETASKS=`"!desktopicon,!desktopicon\common,!desktopicon\user`""
  validExitCodes  = @(0, 3010, 1641)
}

Install $packageArgs