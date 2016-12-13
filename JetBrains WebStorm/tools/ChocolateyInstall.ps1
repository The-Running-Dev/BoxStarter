$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'WebStorm'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'WebStorm-2016.3.2.exe'
  url             = 'https://download.jetbrains.com/webstorm/WebStorm-2016.3.2.exe'
  softwareName    = 'WebStorm*'
  checksum        = '178EED73575DB3FC01CF22B430BB80EC78A9FC3E4DA27DF24F36740D3895C554'
  checksumType    = 'sha256'
  silentArgs      = '/S'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $packageArgs