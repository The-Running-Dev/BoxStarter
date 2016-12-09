$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'ReSharper'
  unzipLocation   = (GetCurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (GetParentDirectory $script) 'JetBrains.ReSharperUltimate.2016.2.2.exe'
  url             = 'https://download.jetbrains.com/resharper/JetBrains.ReSharperUltimate.2016.2.2.exe'
  softwareName    = 'ReSharper*'
  checksum        = 'eccad508fb83428f8c5a3a9a4fc9d930251f101f4929845fc4aea3ab004169dd'
  checksumType    = 'sha256'
  silentArgs      = '/VsVersion=14.0;15.0 /SpecificProductNames=dotCover;dotMemory;dotPeek;dotTrace;ReSharperCpp;teamCityAddin;ReSharper /Silent=True'
  validExitCodes  = @(0, 3010, 1641)
}

Install $packageArgs