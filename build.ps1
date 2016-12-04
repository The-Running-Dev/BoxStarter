param(
    [string] $package
)

Import-Module (Join-Path $PSScriptRoot 'build-helpers.psm1')

$artifactsPath = Join-Path $PSScriptRoot 'Artifacts'

if (Test-Path($artifactsPath)) {
    Remove-Item $artifactsPath\** -Recurse -Force
}

New-Item -Path $artifactsPath -ItemType Directory -Force

if ($package -eq '') {
    foreach ($p in (Get-ChildItem -Path $PSScriptRoot -Filter *.nuspec -Recurse)) {
        CompileAutoHotKey((Split-Path -Parent $p.FullName))

        choco pack $p.FullName --outputdirectory $artifactsPath
    }
}
else {
    $packages = Get-ChildItem -Path $PSScriptRoot -Filter *.nuspec -Recurse | Where-Object { $_.Name -match "^$package.*"}

    foreach ($p in $packages) {
        CompileAutoHotKey((Split-Path -Parent $p.FullName))

        choco pack $p.FullName --outputdirectory $artifactsPath
    }
}