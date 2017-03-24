& .\build.ps1 DevHelpers

choco uninstall DevHelpers.extension -f
choco install DevHelpers.extension -s .\Artifacts