$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'WebPI'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'wpilauncher.exe'
  url             = 'https://go.microsoft.com/fwlink/?LinkId=255386'
  softwareName    = 'WebPI*'
  checksum        = '5CA3400C444CF4B970833E0986656E907A318DBA4F85D37E70512D67B3087710'
  checksumType    = 'sha256'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $packageArgs

Start-Sleep -s 5

if (Get-Process -Name WebPlatformInstaller) {
  Stop-Process -processname WebPlatformInstaller
}