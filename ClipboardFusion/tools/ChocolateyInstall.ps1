$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'ClipboardFusion'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'ClipboardFusionSetup-4.2.exe'
  url             = 'https://www.binaryfortress.com/Data/Download/?package=clipboardfusion&log=104'
  softwareName    = 'ClipboardFusion*'
  checksum        = 'EF1ABF166F7D76F73B2E245207B0D26BDB87840CB6835BE705161610DCA6498E'
  checksumType    = 'sha256'
  silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments