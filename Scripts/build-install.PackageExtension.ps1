$packagesDir = Join-Path $PSScriptRoot '..\..\..\BoxStarter\Extensions' -Resolve

choco uninstall Chocolatey-Package.extension -f
choco pack (Join-Path -Resolve $PSScriptRoot '..\Chocolatey-Package.extension\Chocolatey-Package.extension.nuspec') --outputdirectory $packagesDir
choco install Chocolatey-Package.extension -f