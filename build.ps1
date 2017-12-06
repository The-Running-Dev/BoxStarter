param (
    [Parameter(Position = 0)][String] $searchTerm,
    [Parameter(Position = 1)][switch] $remote,
    [Parameter(Position = 2)][switch] $force
)

. .\Scripts\New-ChocoPackage.ps1

$include = '*.zip,*.msi,*.exe'
$artifacts = '..\..\BoxStarter'
$vaseSir = $PSScriptRoot
$searchTerm = $searchTerm -replace '\.\\(.*?)\\', '$1'
$filter = '*.nuspec'

if (-not $searchTerm) {
    # Get all packages in the base directory and sub directories
    $packages = (Get-ChildItem -Path $baseDir -Filter $filter -Recurse)
}
else {
    $packages = @()

    foreach ($p in $searchTerm.split(' ')) {
        $packages += Get-ChildItem -Path $baseDir -Filter $filter -Recurse | Where-Object { $_.Name -match ".*?$p.*"}
    }
}

foreach ($p in $packages) {
    $currentDir = Split-Path -Parent $p.FullName

    Push-Location $currentDir
    New-ChocoPackage $p.FullName $artifacts $include $force
    Pop-Location
}