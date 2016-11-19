Write-Host "Building Chocolatey Pacakges"

$artifactsPath = Join-Path $PSScriptRoot 'Artifacts'

if (Test-Path($artifactsPath)) {
    Remove-Item $artifactsPath\** -Recurse -Force
}

New-Item -Path $artifactsPath -ItemType Directory -Force

foreach ($nuspec in (Get-ChildItem -Path $PSScriptRoot -Filter *.nuspec -Recurse)){
    choco pack $nuspec.FullName --outputdirectory $artifactsPath
}