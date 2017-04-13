param([switch] $force)

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $productName = 'DataGrip'
    $releaseUrl = 'https://www.jetbrains.com/updates/updates.xml'
    $downloadUrl = 'https://download.jetbrains.com/datagrip/datagrip-$($version).exe'

    [xml] $updates = (New-Object System.Net.WebClient).DownloadString($releaseUrl)
    $versionInfo = $updates.products.product `
        | Where-Object { $_.name -eq $productName } `
        | ForEach-Object { $_.channel } `
        | ForEach-Object { $_.build } `
        | Sort-Object { [version] $_.fullNumber } `
        | Select-Object -Last 1

    $version = $versionInfo.Version

    if (!($version -match '\d+\.\d+')) {
        $version = "$($version).$($versionInfo.ReleaseDate)"
    }

    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')