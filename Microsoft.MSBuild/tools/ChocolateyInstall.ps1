$installer        = 'Microsoft.MSBuild.zip'
$packageChecksum  = ''
$arguments        = @{
  packageName     = $env:ChocolateyPackageName
  fileFullPath    = Join-Path $env:ChocolateyPackageFolder $installer
  destination     = 'C:\Program Files (x86)\MSBuild'
}

Get-ChocolateyUnzip @arguments