$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'WebStorm'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'WebStorm-2016.3.1.exe'
  url             = 'https://download.jetbrains.com/webstorm/WebStorm-2016.3.1.exe'
  softwareName    = 'WebStorm*'
  checksum        = '87712823afbebe127471cb66674d22381be5e279470cb4c0b62d8b2638768c61'
  checksumType    = 'sha256'
  silentArgs      = '/S'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $packageArgs