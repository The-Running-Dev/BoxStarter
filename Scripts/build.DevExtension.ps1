$packagesDir = Join-Path $PSScriptRoot '..\..\..\BoxStarter' -Resolve

choco uninstall Chocolatey-Dev.extension -f
Remove-Item -Recurse C:\ProgramData\Chocolatey\extensions\chocolatey-Dev -ErrorAction SilentlyContinue

choco pack (Join-Path -Resolve $PSScriptRoot '..\Chocolatey-Dev.extension\Chocolatey-Dev.extension.nuspec') --outputdirectory $packagesDir
choco install Chocolatey-Dev.extension -f