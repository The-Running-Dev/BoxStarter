$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'NodeJS'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'msi'
  file            = Join-Path (Get-ParentDirectory $script) 'ClipboardFusionSetup-4.2.exe'
  url             = 'https://nodejs.org/dist/v7.2.1/node-v7.2.1-x86.msi'
  url64           = 'https://nodejs.org/dist/v7.2.1/node-v7.2.1-x64.msi'
  softwareName    = 'NodeJS*'
  checksum        = '8302C95D26D343C131F403C088F8812540F4BEBC5A01A98972599C03658E547B'
  checksum64      = '789AF29EBA3A43213DFAB7A71ADA7E2C513A9FA023F0987B2076B10754DA907E'
  checksumType    = 'sha256'
  checksumType64  = 'sha256'
  silentArgs      = '/quiet /LAUNCHAFTER=0'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $packageArgs

$nodePath = "$(Get-ProgramFilesDirectory)\NodeJS"
$env:Path = "$($env:Path);$nodePath"