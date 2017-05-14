param([switch] $force)

$baseDir = Join-Path $PSScriptRoot 'Base'
$baseZip = Join-Path $PSScriptRoot 'Base.zip'

if (Test-Path $baseZip) {
    New-Item -ItemType Directory $baseDir -Force | Out-Null
    Expand-Archive $baseZip $baseDir

    if ($force) {
        & "$baseDir\install.choco.ps1" -Force
    }
    else {
        & "$baseDir\install.choco.ps1"
    }

    Remove-Item $baseZip -Force
    Remove-Item $baseDir -Recurse -Force
    Remove-Item "$PSScriptRoot\install.base.ps1" -Force
}