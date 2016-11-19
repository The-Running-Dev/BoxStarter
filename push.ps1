$configFile = 'config.json'
$configPath = Join-Path $PSScriptRoot $configFile -Resolve

$config = (Get-Content $configPath -Raw) | ConvertFrom-Json

foreach ($artifact in (Get-ChildItem -Path $artifactsPath -Filter *.nupkg -Recurse)){
    choco push $artifact.FullName -s $config.source -k=$config.apiKey
}