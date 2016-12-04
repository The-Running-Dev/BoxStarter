$script           = $MyInvocation.MyCommand.Definition
$packageName      = 'webStorm'
$installer        = Join-Path (GetParentDirectory $script) 'WebStorm-2016.3.1.exe'
$url              = 'https://download.jetbrains.com/webstorm/WebStorm-2016.3.1.exe'
$packageArgs      = @{
  packageName     = $packageName
  unzipLocation   = (GetCurrentDirectory $script)
  fileType        = 'exe'
  file            = $installer
  url             = $url
  softwareName    = 'DataGrip*'
  checksum        = '87712823afbebe127471cb66674d22381be5e279470cb4c0b62d8b2638768c61'
  checksumType    = 'sha256'
  silentArgs      = '/S'
  validExitCodes  = @(0, 3010, 1641)
}

InstallFromLocalOrRemote $packageArgs