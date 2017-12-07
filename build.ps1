param (
    [Parameter(Position = 0)][string] $searchTerm,
    [Parameter(Position = 2)][switch] $force,
    [Parameter(Position = 3)][string] $baseDir = $PSScriptRoot
)

$include = '*.zip,*.msi,*.exe'
$artifacts = '..\..\BoxStarter'
$baseDir = $PSScriptRoot
$searchTerm = $searchTerm -replace '\.\\(.*?)\\', '$1'
$filter = '*.nuspec'

$artifactsPath = Join-Path $baseDir $artifacts -Resolve

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
    New-ChocoPackage $p.FullName $artifactsPath $include $force
    Pop-Location
}