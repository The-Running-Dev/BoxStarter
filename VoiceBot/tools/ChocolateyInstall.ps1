$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'VoiceBot'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'VoiceBotSetup-3.0.exe'
  url             = 'https://www.binaryfortress.com/Data/Download/?package=voicebot&log=123'
  softwareName    = 'VoiceBot*'
  checksum        = '8BC560E85A844F6FD0412E6BD43028F30CB6ACD14AFE4092F02C70072E69BEA9'
  checksumType    = 'sha256'
  silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments