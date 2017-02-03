$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'WebStorm'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'WebStorm-2016.3.3.exe'
  url             = 'https://download.jetbrains.com/webstorm/WebStorm-2016.3.3.exe'
  softwareName    = 'WebStorm*'
  checksum        = '48b866ac9e2d8860b1c60b4a6da77e8b725467f0c49ec9c9a765429718ea582e'
  checksumType    = 'sha256'
  silentArgs      = '/S'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments