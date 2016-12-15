$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'IIS.UrlRewrite'
  softwareName    = 'IIS URL Rewrite Module 2'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'msi'
  file            = Join-Path (Get-ParentDirectory $script) 'rewrite_amd64.msi'
  url             = 'http://download.microsoft.com/download/5/4/9/54980B19-9C64-4E8E-A69C-615A88DFF8B7/rewrite_x86.msi'
  url64           = 'http://download.microsoft.com/download/C/9/E/C9E8180D-4E51-40A6-A9BF-776990D8BCA9/rewrite_amd64.msi'
  checksum        = 'E120F29A61474E9B6C828AD69065895587B5D72AFD3D0847BFA70D34C49C9DFA'
  checksum64      = '64F99F1F8521B735CAFC64AF14344FFC075B3B0D7CD4BD0D0826DB5F8C45F4EA'
  checksumType    = 'sha256'
  checksumType64  = 'sha256'
  silentArgs      = "/qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments