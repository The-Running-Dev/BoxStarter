param (
    [Parameter(Position = 0)][String] $searchTerm,
    [Parameter(Position = 2)][switch] $force,
    [Parameter(Position = 3)][string] $baseDir = $PSScriptRoot
)

$artifacts = '..\..\BoxStarter'
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
    $packageAritifactRegEx = $p.Name -replace '(.*?).nuspec', '$1([0-9\.]+)\.nupkg'

    $packageToPush = Get-ChildItem -Path $baseDir -Recurse -File `
        | Where-Object { $_.Name -match $packageAritifactRegEx } `
        | Select-Object FullName

    if ($packageToPush) {
        write-host "Package: $packageToPush"

        # Delete any previous versions of the same package
        $previousVersion = Get-ChildItem $artifactsPath -Recurse -File `
            | Where-Object { $_.Name -match $packageAritifactRegEx }

        if ($previousVersion) {
            Write-Host "Deleting previous version '$($previousVersion.FullName)'..."
            #Remove-Item $previousVersion.FullName
        }

        $packageToPush | ForEach-Object {
            Write-Host "Pushing $($_.FullName) to $artifactsPath..."
            #choco push $_.FullName -s $$artifactsPath -f
            #Remove-Item $_.FullName
        }
    }
}