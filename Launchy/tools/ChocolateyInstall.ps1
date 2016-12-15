$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'Launchy'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'LaunchySetup2.6B2.exe'
  url             = 'http://launchy.net/downloads/win/LaunchySetup2.6B2.exe'
  softwareName    = 'Launchy*'
  checksum        = '49E6E7F0FDD9BD16E30D827AC421BD9AFD5DD281577A9B08E8A0C3F91BAD62A1'
  checksumType    = 'sha256'
  silentArgs      = '/verysilent'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments 