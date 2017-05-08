$baseDir = Join-Path $PSScriptRoot 'Base'
$baseZip = Join-Path $PSScriptRoot 'Base.zip'

if (Test-Path $baseZip) {
    Expand-Archive $baseZip $baseDir

    & "$baseDir\install.choco.ps1"

    Remove-Item $baseZip -Force
    Remove-Item $baseDir -Recurse -Force
    Remove-Item "$PSScriptRoot\install.base.ps1" -Force
}