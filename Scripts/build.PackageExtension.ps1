$packagesDir = Join-Path $PSScriptRoot '..\..\..\BoxStarter' -Resolve

choco uninstall Chocolatey-Package.extension -f
Remove-Item -Recurse C:\ProgramData\Chocolatey\extensions\chocolatey-Package -ErrorAction SilentlyContinue

choco pack (Join-Path -Resolve $PSScriptRoot '..\Chocolatey-Package.extension\Chocolatey-Package.extension.nuspec') --outputdirectory $packagesDir
choco install Chocolatey-Package.extension -f