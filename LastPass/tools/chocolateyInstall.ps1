$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'LastPass'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'lastappinstall_x64.exe'
  url             = 'https://lastpass.com/download/cdn/lastappinstall_x64.exe'
  softwareName    = 'LastPass*'
  checksum        = '29CB9F2E69CFED90DCEFBEC8A13615BA7DB9C1B74AE6EFFAD1D0E0A078A30BB9'
  checksumType    = 'sha256'
  silentArgs      = '-si'
  validExitCodes  = @(0, 3010, 1641)
}

# Launch the AutoHotkey script that install the application
Start-Process (Join-Path (Get-ParentDirectory $script) 'Install.exe')

Install-LocalOrRemote $arguments