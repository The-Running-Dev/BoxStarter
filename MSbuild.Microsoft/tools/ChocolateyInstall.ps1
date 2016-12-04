$packagePath = Split-Path -parent $PSScriptRoot
$MSBuildTargets = Join-Path $packagePath 'MSBuild.Microsoft.zip' 

Get-ChocolateyUnzip -FileFullPathMSBuildTargets -Destination 'C:\Program Files (x86)\MSBuild'

# Unzip the MSBuild targets
# Unzip MSBuildTargets 'C:\Program Files (x86)\MSBuild'