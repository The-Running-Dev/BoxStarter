param(
    [string] $package,
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
    $source = $config.local.source
    $apiKey = $config.local.apiKey
}

if ($package -eq '') {
    foreach ($p in (Get-ChildItem -Path $artifactsPath -Filter *.nupkg)){
        choco push $p.FullName -s $source -k=$apiKey
    }
}
else {
    $packages = Get-ChildItem -Path $artifactsPath | Where-Object { $_.Name -match "^$package.*"}

    foreach ($p in $packages) {
        choco push $p.FullName -s $source -k=$apiKey
    }
}