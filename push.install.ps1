$boxstarterInstallScripts = Join-Path -Resolve $PSSCriptRoot '..\..\BoxStarter'
$nasInstallScripts = '\\nas\Applications\_BoxStarter'

New-Item -ItemType Directory $boxstarterInstallScripts\Install -Force | Out-Null

Copy-Item -Recurse $PSSCriptRoot\_Install\** $boxstarterInstallScripts\Install\ -Force

if (Test-Path $nasInstallScripts) {
    New-Item -ItemType Directory $nasInstallScripts\Install -Force | Out-Null
    Copy-Item -Recurse $PSSCriptRoot\_Install\** $nasInstallScripts\Install\ -Force
}