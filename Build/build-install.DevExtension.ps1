choco uninstall Chocolatey-Dev.extension -f

& $PSScriptRoot\build-push.ps1 Chocolatey-Dev.extension

choco install Chocolatey-Dev.extension -f