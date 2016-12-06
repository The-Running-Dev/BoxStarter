$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'RazerSynapse'
  unzipLocation   = (GetCurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (GetParentDirectory $script) 'Razer_Synapse_Framework_V2.20.15.1104'
  url             = 'https://www.razerzone.com/synapse/downloadpc'
  softwareName    = 'RazerSynapse*'
  checksum        = 'A568786FEE965F8AC2B8F9942521E1D2B08EFFC566D8471917C2233FEA49700F'
  checksumType    = 'sha256'
  silentArgs      = '/s'
  validExitCodes  = @(0, 3010, 1641)
}

Start-Process (Join-Path (GetParentDirectory $script) 'Install.exe')

Start-Sleep 10

Install $packageArgs