$boxstarterInstallScripts = Join-Path -Resolve $PSSCriptRoot '..\..\BoxStarter'
$nasInstallScripts = '\\nas\Applications\_BoxStarter'

Copy-Item -Recurse $PSSCriptRoot\Install $boxstarterInstallScripts -Force
Copy-Item -Recurse $PSSCriptRoot\Install $nasInstallScripts -Force