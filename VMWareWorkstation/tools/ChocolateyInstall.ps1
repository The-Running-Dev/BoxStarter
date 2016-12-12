$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'VMWareWorkstation'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'VMware-workstation-full-12.5.2-4638234.exe'
  url             = 'https://download3.vmware.com/software/wkst/file/VMware-workstation-full-12.5.2-4638234.exe'
  softwareName    = 'VMWareWorkstation*'
  checksum        = '402E2DEAA840D807B86D4116FD6E8FCFC1A0C362AC05F87396C09F1153B2F8C8'
  checksumType    = 'sha256'
  silentArgs      = '/s /nsr /v/qn EULAS_AGREED=1'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $packageArgs