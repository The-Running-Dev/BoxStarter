$packagesDir = Join-Path $PSScriptRoot '..\..\..\BoxStarter\Extensions' -Resolve

choco uninstall Chocolatey-Dev.extension -f
choco pack (Join-Path -Resolve $PSScriptRoot '..\Chocolatey-Dev.extension\Chocolatey-Dev.extension.nuspec') --outputdirectory $packagesDir
choco install Chocolatey-Dev.extension -f