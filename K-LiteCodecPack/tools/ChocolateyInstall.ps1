$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'K-LiteCodecPack'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'K-Lite_Codec_Pack_1290_Mega'
  url             = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1290_Mega.exe'
  softwareName    = 'K-LiteCodecPack*'
  checksum        = 'A60ACAC4A69CE520BC9515A50DBA7A63EF20C36F8680071BC30C7F5C1E8E14BE'
  checksumType    = 'sha256'
  silentArgs      = '/VERYSILENT'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments