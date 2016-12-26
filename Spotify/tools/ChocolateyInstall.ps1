$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'Spotify'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'SpotifyFullSetup.exe'
  url             = 'https://download.spotify.com/SpotifyFullSetup.exe'
  softwareName    = 'Spotify*'
  checksum        = 'E6783B3D935117700D64843DACB719CDAEF9BD5F2254950B7BBF8BD8E9B9ECE4'
  checksumType    = 'sha256'
  silentArgs      = '/silent'
  validExitCodes  = @(0, 3010, 1641)
}

Install-WithScheduledTask $arguments

$done = $false
do {
  if (Get-Process Spotify -ErrorAction SilentlyContinue) {
    Stop-Process -name Spotify
    $done = $true
  }

  Start-Sleep -s 10
} until ($done)