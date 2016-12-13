$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'DataGrip'
  unzipLocation   = (Get-CurrentDirectory $script)
  file            = Join-Path (Get-ParentDirectory $script) 'Datagrip-2016.3.1.exe'
  fileType        = 'exe'
  url             = 'https://download.jetbrains.com/datagrip/Datagrip-2016.3.1.exe'
  softwareName    = 'DataGrip*'
  checksum        = 'F2ABD6477A2F22C277B6A8297AF04A5CFBB9630E858D20CE18CB4C2FC45AE4D1'
  checksumType    = 'sha256'
  silentArgs      = '/S'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $packageArgs