choco uninstall Chocolatey-Package.extension -f -ErrorAction SilentlyContinue

& $PSScriptRoot\build-push.ps1 Chocolatey-Package.extension

choco install Chocolatey-Package.extension -f