$packageArgs    = @{
  packageName   = 'MSBuild.Microsoft'
  FileFullPath  = Join-Path (GetParentDirectory $script) 'MSBuild.Microsoft.zip'
  Destination   = 'C:\Program Files (x86)\MSBuild'
}

Get-ChocolateyUnzip -FileFullPathMSBuildTargets -Destination 
# UnzipSafe MSBuildTargets 'C:\Program Files (x86)\MSBuild'