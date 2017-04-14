& $PSScriptRoot\setup.ps1

choco install LogFusion.Personal
& "${env:ProgramFiles(x86)}\LogFusion\LogFusion.exe" $env:log

choco install Office365Business.Personal