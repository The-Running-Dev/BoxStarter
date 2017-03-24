param(
    [string] $packages,
    [string] $source
)

$configFile = 'config.json'
$artifacts = 'Artifacts'

$configPath = Join-Path $PSScriptRoot $configFile -Resolve
$artifactsPath = Join-Path $PSScriptRoot $artifacts -Resolve

$config = (Get-Content $configPath -Raw) | ConvertFrom-Json

if ($source -Match 'remote') {
    $source = $config.remote.source
    $apiKey = $config.remote.apiKey
}
else {
    $source = Join-Path -Resolve . $config.local.source
    $apiKey = $config.local.apiKey
}

if ($packages -eq '') {
    foreach ($p in (Get-ChildItem -Path $artifactsPath -Filter *.nupkg)){
        choco push $p.FullName -s $source -k="$apiKey"
    }
}
else {
    $foundPackages = Get-ChildItem -Path $artifactsPath -Exclude Drivers | Where-Object { $_.Name -match "^$packages.*"}

    foreach ($p in $foundPackages) {
        choco push $p.FullName -s $source -k="$apiKey"
    }
}