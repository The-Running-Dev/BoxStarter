$script         = $MyInvocation.MyCommand.Definition
$arguments      = @{
  packageName   = 'MSBuild.Microsoft'
  fileFullPath  = Join-Path (Get-ParentDirectory $script) 'MSBuild.Microsoft.zip'
  destination   = 'C:\Program Files (x86)\MSBuild'
}

Get-ChocolateyUnzip @arguments