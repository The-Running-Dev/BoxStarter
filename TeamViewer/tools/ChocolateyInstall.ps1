$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'TeamViewer'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'TeamViewer_Setup.exe'
  url             = 'https://download.teamviewer.com/download/version_11x/TeamViewer_Setup.exe'
  softwareName    = 'TeamViewer*'
  checksum        = '193C2A6D5FBC1912506F34C2E9E3C4F771FB37BD706489A89596B3E624BC8351'
  checksumType    = 'sha256'
  silentArgs      = '/S'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $packageArgs