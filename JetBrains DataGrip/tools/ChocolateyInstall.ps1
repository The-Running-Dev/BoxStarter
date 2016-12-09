$script           = $MyInvocation.MyCommand.Definition
$url              = 'https://download.jetbrains.com/datagrip/datagrip-2016.3.exe'
$packageArgs      = @{
  packageName     = 'DataGrip'
  unzipLocation   = (GetCurrentDirectory $script)
  file            = Join-Path (GetParentDirectory $script) 'DataGrip-2016.3.exe'
  fileType        = 'exe'
  url             = $url
  softwareName    = 'DataGrip*'
  checksum        = '76C57FD30939038AFB7CCAEBAC921FBDFC0A1C4CF2AD21026FC64DF110A88621'
  checksumType    = 'sha256'
  silentArgs      = '/S'
  validExitCodes  = @(0, 3010, 1641)
}

Install $packageArgs