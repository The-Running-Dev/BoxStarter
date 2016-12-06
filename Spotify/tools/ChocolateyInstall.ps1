$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'Spotify'
  unzipLocation   = (GetCurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (GetParentDirectory $script) 'SpotifyFullSetup.exe'
  url             = 'https://download.spotify.com/SpotifyFullSetup.exe'
  softwareName    = 'Spotify*'
  checksum        = 'DC1770943FCFADC07DF5E399BA89D071E1E82311284860573C08E05D31BBF965'
  checksumType    = 'sha256'
  silentArgs      = '/silent'
  validExitCodes  = @(0, 3010, 1641)
}

InstallWithScheduledTaks $packageArgs

$done = $false
do {
  if (Get-Process Spotify -ErrorAction SilentlyContinue) {
    Stop-Process -name Spotify
    $done = $true
  }

  Start-Sleep -s 10
} until ($done)