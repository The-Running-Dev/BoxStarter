$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'GitExtensions'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'msi'
  file            = Join-Path (Get-ParentDirectory $script) 'GitExtensions-2.49-SetupComplete.msi'
  url             = 'https://github.com/gitextensions/gitextensions/releases/download/v2.49/GitExtensions-2.49-SetupComplete.msi'
  softwareName    = 'GitExtensions*'
  checksum        = '963DA579825BBCB11E51853A9D009531F454C12D0933F920F68E6D2CDAEF8032'
  checksumType    = 'sha256'
  silentArgs      = '/quiet /norestart'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $packageArgs