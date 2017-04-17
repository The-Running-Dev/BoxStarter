$boxstarterInstallScripts = Join-Path -Resolve $PSSCriptRoot '..\..\BoxStarter'
$nasInstallScripts = '\\nas\Applications\_BoxStarter'

Copy-Item -Recurse $PSSCriptRoot\Install $boxstarterInstallScripts -Force

if (Test-Path $nasInstallScripts) {
    Copy-Item -Recurse $PSSCriptRoot\Install $nasInstallScripts -Force
}