choco uninstall Chocolatey-PackageHelpers.extension -f -ErrorAction SilentlyContinue

& $PSScriptRoot\build-push.ps1 Chocolatey-PackageHelpers.extension

choco install Chocolatey-PackageHelpers.extension -f