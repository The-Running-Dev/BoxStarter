param(
    [string] $packages
)

& $PSScriptRoot\setup.ps1

$foundPackages = Get-ChildItem -Path $env:packagesSourcePath -Filter *.nupkg -Recurse | Where-Object { $_.Name -match "^$packages.*"}

foreach ($p in $foundPackages) {
    choco install $($p.Name -replace '^(.*?)\.\d+.*', '$1') -r -f
}