$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'ReSharper'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'JetBrains.ReSharperUltimate.2016.3.1.exe'
  url             = 'https://download.jetbrains.com/resharper/JetBrains.ReSharperUltimate.2016.3.1.exe'
  softwareName    = 'ReSharper*'
  checksum        = 'db7fa2555380c38a89a58d4b8c745a3239771ac8a2a2f5d173cda245ef84992'
  checksumType    = 'sha256'
  silentArgs      = '/VsVersion=14.0;15.0 /SpecificProductNames=dotCover;dotMemory;dotPeek;dotTrace;ReSharperCpp;teamCityAddin;ReSharper /Silent=True'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments