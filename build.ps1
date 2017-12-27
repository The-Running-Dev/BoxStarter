param (
    [Parameter(Position = 0)][string[]] $searchTerm,
    [Parameter(Position = 1)][switch] $force,
    [Parameter(Position = 2)][string] $baseDir = $PSScriptRoot
)

Import-Module "$PSScriptRoot\PowerShell-Helpers.extension\extensions\PowerShell-Helpers.extension.psm1" -Force

$include = '*.zip,*.msi,*.exe'
$artifacts = '..\..\BoxStarter'

if (Test-Path variable:\au_settingsDir) {
    Remove-Item variable:\au_settingsDir
}

if (Test-Path variable:\au_Version) {
    Remove-Item variable:\au_Version
}

if (Test-Path variable:\au_isFixedVersion) {
    Remove-Item variable:\au_isFixedVersion
}

$artifactsPath = Join-Path $baseDir $artifacts -Resolve

if (-not $searchTerm) {
    # Get all packages in the base directory and sub directories
    $packages = (Get-ChildItem -Path $baseDir -Filter *.nuspec -Recurse)
}
else {
    $packages = @()

    foreach ($p in $searchTerm.split(' ')) {
        $p = $p -replace '\.\\(.*?)\\', '$1'
        $packages += gci *.nuspec -Recurse -Path $baseDir | ? { $_.Name -match $p }
    }
}

foreach ($p in $packages) {
    $currentDir = Split-Path -Parent $p.FullName

    Push-Location $currentDir
    New-ChocoPackage $p.FullName $artifactsPath $include $force
    Pop-Location

    $packageAritifactRegEx = $p.Name -replace '(.*?).nuspec', '$1([0-9\.]+)\.nupkg'

    Get-ChildItem $artifactsPath -Recurse -File `
        | Where-Object { $_.Name -match $packageAritifactRegEx } `
        | Sort-Object -Descending -Property LastWriteTime | Skip-Object 1 `
        | ForEach-Object {
        Write-Host "Deleting previous version '$($_.FullName)'..."
        Remove-Item $_.FullName
    }
}