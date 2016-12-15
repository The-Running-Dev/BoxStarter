$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'IIS.ExternalCache'
  softwareName    = 'Microsoft External Cache'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'msi'
  file            = Join-Path (Get-ParentDirectory $script) 'ExternalDiskCache_amd64.msi'
  url             = 'http://download.microsoft.com/download/D/C/E/DCEE2E97-3008-474F-896C-54E9DFE4C81B/ExternalDiskCache_x86.msi'
  url64           = 'http://download.microsoft.com/download/C/A/5/CA5FAD87-1E93-454A-BB74-98310A9C523C/ExternalDiskCache_amd64.msi'
  checksum        = '65057F3A118DF288C0FBAE7F629814774DADE974E6B35236BE1CF343E5E99197'
  checksum64      = '6BF8E5FDA2B993193B922C977AA8D41F78262C5DB0F04305EC19434C2AB5FA53'
  checksumType    = 'sha256'
  checksumType64  = 'sha256'
  silentArgs      = "/qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments