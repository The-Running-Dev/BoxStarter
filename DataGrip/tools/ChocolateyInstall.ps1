$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'DataGrip'
  unzipLocation   = (Get-CurrentDirectory $script)
  file            = Join-Path (Get-ParentDirectory $script) 'Datagrip-2016.3.2.exe'
  fileType        = 'exe'
  url             = 'https://download.jetbrains.com/datagrip/datagrip-2016.3.2.exe'
  softwareName    = 'DataGrip*'
  checksum        = '94329F94ED1488FC9179A7A65091468FABDD672A57AC138033C953AF1D7F68F3'
  checksumType    = 'sha256'
  silentArgs      = '/S'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments