param(
    [string] $package
)

$configFile = 'config.json'
$artifacts = 'Artifacts'

$configPath = Join-Path $PSScriptRoot $configFile -Resolve
$artifactsPath = Join-Path $PSScriptRoot $artifacts -Resolve

$config = (Get-Content $configPath -Raw) | ConvertFrom-Json

if ($package -eq '') {
    foreach ($artifact in (Get-ChildItem -Path $artifactsPath -Filter *.nupkg)){
        choco push $artifact.FullName -s "$($config.source)" -k="$($config.apiKey)"
    }
}
else {
    $packages = Get-ChildItem -Path $artifactsPath | Where-Object { $_.Name -match "^$package.*"}
    
    foreach ($p in $packages) {
        choco push $p.FullName -s "$($config.source)" -k="$($config.apiKey)"
    }
}