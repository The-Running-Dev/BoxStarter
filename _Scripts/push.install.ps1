$localBoxStarterPublishDir = Join-Path $PSSCriptRoot '..\..\..\BoxStarter' -Resolve
$localBoxStarterPublishInstallDir = Join-Path $localBoxStarterPublishDir 'Install'

$nasBoxStarterDir = '\\nas\Applications\_BoxStarter'
$nasBoxStarterInstallDir = Join-Path $nasBoxStarterDir 'Install'

$installScripts = Join-Path $PSSCriptRoot '..\_Install' -Resolve

if (Test-Path $localBoxStarterPublishInstallDir) {
    Remove-Item -Recurse $localBoxStarterPublishInstallDir -Force | Out-Null
}
New-Item -ItemType Directory $localBoxStarterPublishInstallDir -Force | Out-Null
Copy-Item -Recurse $installScripts\** $localBoxStarterPublishInstallDir\ -Force

if (Test-Path $nasBoxStarterDir) {
    if (Test-Path $nasBoxStarterInstallDir) {
        Remove-Item -Recurse $nasBoxStarterInstallDir -Force | Out-Null
    }
    New-Item -ItemType Directory $nasBoxStarterInstallDir -Force | Out-Null
    Copy-Item -Recurse $installScripts\** $nasBoxStarterInstallDir\ -Force
}