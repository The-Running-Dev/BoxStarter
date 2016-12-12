$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'Spotify'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'SpotifyFullSetup.exe'
  url             = 'https://download.spotify.com/SpotifyFullSetup.exe'
  softwareName    = 'Spotify*'
  checksum        = '73E04000E01EF36D607077E8E0D5925E4A7D757158C7AC53341087B79E12A43D'
  checksumType    = 'sha256'
  silentArgs      = '/silent'
  validExitCodes  = @(0, 3010, 1641)
}

Install-WithScheduledTask $packageArgs

$done = $false
do {
  if (Get-Process Spotify -ErrorAction SilentlyContinue) {
    Stop-Process -name Spotify
    $done = $true
  }

  Start-Sleep -s 10
} until ($done)