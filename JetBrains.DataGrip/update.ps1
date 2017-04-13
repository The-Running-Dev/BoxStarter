param([switch] $force)

. (Join-Path $PSScriptRoot '..\Build\update.begin.ps1')

function global:au_GetLatest {
    $productName = 'DataGrip'
    $updatesUri = 'https://www.jetbrains.com/updates/updates.xml'
    $downloadUrl = 'https://download.jetbrains.com/datagrip/datagrip-$($version).exe'

    [xml] $updates = (New-Object System.Net.WebClient).DownloadString($updatesUri)
    $versionInfo = $updates.products.product `
    | ? { $_.name -eq $productName } `
    | % { $_.channel } `
    | % { $_.build } `
    | Sort-Object { [version] $_.fullNumber } `
    | Select-Object -Last 1

    $version = $versionInfo.Version

    if ($versionInfo.ReleaseDate) {
        $fullVersionNumber = "$($versionInfo.Version).$($versionInfo.ReleaseDate)"
    }
    else {
        $fullVersionNumber = "$($versionInfo.Version).0.0"
    }

    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $fullVersionNumber }
}

. (Join-Path $PSScriptRoot '..\Build\update.end.ps1')