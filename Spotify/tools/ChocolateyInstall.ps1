$script           = $MyInvocation.MyCommand.Definition
$packageName      = 'Spotify'
$installer        = Join-Path (GetParentDirectory $script) 'SpotifyFullSetup.exe'
$url              = 'http://download.spotify.com/SpotifyFullSetup.exe'
$packageArgs      = @{
  packageName     = $packageName
  unzipLocation   = (GetCurrentDirectory $script)
  fileType        = 'exe'
  file            = $installer
  url             = $url
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
    Write-Host "About to Kill"
    Stop-Process -name Spotify
    $done = $true
  }

  Start-Sleep -s 10
} until ($done)