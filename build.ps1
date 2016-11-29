param(
    [string] $package
)

$artifactsPath = Join-Path $PSScriptRoot 'Artifacts'

if (Test-Path($artifactsPath)) {
    Remove-Item $artifactsPath\** -Recurse -Force
}

New-Item -Path $artifactsPath -ItemType Directory -Force

echo $package

if ($package -eq '') {
    foreach ($nuspec in (Get-ChildItem -Path $PSScriptRoot -Filter *.nuspec -Recurse)){
       choco pack $nuspec.FullName --outputdirectory $artifactsPath
    }
}
else {
    $packages = Get-ChildItem -Path $PSScriptRoot -Filter *.nuspec -Recurse | Where-Object { $_.Name -match "^$package.*"}

    foreach ($p in $packages) {
        choco pack $p.FullName --outputdirectory $artifactsPath
    }
}