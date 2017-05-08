$baseDir = Join-Path $PSScriptRoot '..\..\..\BoxStarter' -Resolve

$packages = @{}
$duplicatePackages = @()

Get-ChildItem $baseDir -Recurse -File -Filter *.nupkg | Sort-Object CreationTime -Descending | ForEach-Object {
    $packageName = $_.Name -replace '(.*?)\.([0-9\.]+).nupkg', '$1'

    if ($packages.ContainsKey($packageName)) {
        $duplicatePackages += $_.FullName
    }
    else {
        $packages[$packageName] += $_.FullName
    }
}

$duplicatePackages | ForEach-Object {
    Write-Host "Removing $_"
    Remove-Item $_ -Force | Out-Null
}