$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'K-LiteCodecPack'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'K-Lite_Codec_Pack_1280_Mega.exe'
  url             = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1280_Mega.exe'
  softwareName    = 'K-LiteCodecPack*'
  checksum        = 'b903a2627ab0b7075b101a38b05d907fd3a82a6c07e67d25d38c70606499d9f6'
  checksumType    = 'sha256'
  silentArgs      = '/VERYSILENT'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments