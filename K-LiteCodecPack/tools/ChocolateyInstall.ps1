$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'K-LiteCodecPack'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'K-Lite_Codec_Pack_1260_Mega.exe'
  url             = 'http://download.betanews.com/download/1080441198-1/K-Lite_Codec_Pack_1260_Mega.exe'
  softwareName    = 'K-LiteCodecPack*'
  checksum        = '593F8A7EAF9CA1E361478685972A53B12412A82E8B9076DAC5DC2E5F72DFD9CE'
  checksumType    = 'sha256'
  silentArgs      = '/VERYSILENT'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments