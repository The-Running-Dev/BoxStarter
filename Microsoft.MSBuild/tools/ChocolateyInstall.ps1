$installer      = 'Microsoft.MSBuild.zip'
$arguments      = @{
  packageName   = 'MSBuild.Microsoft'
  fileFullPath  = Join-Path $env:ChocolateyPackageFolder $installer
  destination   = 'C:\Program Files (x86)\MSBuild'
}

Get-ChocolateyUnzip @arguments