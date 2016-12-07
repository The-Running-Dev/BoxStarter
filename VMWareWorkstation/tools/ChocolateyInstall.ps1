$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'VMWareWorkstation'
  unzipLocation   = (GetCurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (GetParentDirectory $script) 'VMware-workstation-full-12.5.1-4542065.exe'
  url             = 'https://download3.vmware.com/software/wkst/file/VMware-workstation-full-12.5.1-4542065.exe'
  softwareName    = 'VMWareWorkstation*'
  checksum        = '8291675B08960910906F83509B9F851EA645EC2DA7A72B46EDA7BD35461FE2B5'
  checksumType    = 'sha256'
  silentArgs      = '/s /nsr /v/qn EULAS_AGREED=1'
  validExitCodes  = @(0, 3010, 1641)
}

Install $packageArgs