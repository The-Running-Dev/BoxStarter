$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'ReSharper'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'JetBrains.ReSharperUltimate.2016.3.exe'
  url             = 'https://download.jetbrains.com/resharper/JetBrains.ReSharperUltimate.2016.3.exe'
  softwareName    = 'ReSharper*'
  checksum        = '8EAE91EE24AC2F6087B6E3E129DD3A1818E672EBC5259DCACD57A5D17446DAFD'
  checksumType    = 'sha256'
  silentArgs      = '/VsVersion=14.0;15.0 /SpecificProductNames=dotCover;dotMemory;dotPeek;dotTrace;ReSharperCpp;teamCityAddin;ReSharper /Silent=True'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments