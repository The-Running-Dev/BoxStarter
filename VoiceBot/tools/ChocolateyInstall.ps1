$script           = $MyInvocation.MyCommand.Definition
$packageName      = 'VoiceBot'
$installer        = Join-Path (GetParentDirectory $script) 'VoiceBotSetup-3.0.exe'
$url              = 'https://www.binaryfortress.com/Data/Download/?package=voicebot&log=123'

$packageArgs      = @{
  packageName     = $packageName
  unzipLocation   = (GetCurrentDirectory $script)
  fileType        = 'exe'
  file            = $installer
  url             = $url
  softwareName    = 'VoiceBot*'
  checksum        = '8BC560E85A844F6FD0412E6BD43028F30CB6ACD14AFE4092F02C70072E69BEA9'
  checksumType    = 'sha256'
  silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
  validExitCodes  = @(0, 3010, 1641)
}

Install $packageArgs