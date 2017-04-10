choco uninstall Chocolatey-DevHelpers.extension -f -ErrorAction SilentlyContinue

& $PSScriptRoot\build-push.ps1 Chocolatey-DevHelpers.extension

choco install Chocolatey-DevHelpers.extension -f