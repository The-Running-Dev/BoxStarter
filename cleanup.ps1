$baseDir = Join-Path $PSScriptRoot '..\..\BoxStarter' -Resolve

$packages = @{}
$duplicatePackages = @()

Get-ChildItem $baseDir -R -File -Filter *.nupkg | Sort-Object CreationTime -Descending | ForEach-Object {
    $packageName =  $_.Name -replace '(.*?)([0-9\.]+).nupkg', '$1'

    if ($packages.ContainsKey($packageName)) {
        $duplicatePackages += $_.FullName
    } else {
        $packages[$packageName] += $_.FullName
    }
}

$duplicatePackages | ForEach-Object {
    Remove-Item $_
}