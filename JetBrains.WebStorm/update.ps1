. (Join-Path $PSScriptRoot '..\Build\update.common.ps1')

function global:au_GetLatest {
    $productName = 'WebStorm'
    $releasesUrl = 'https://www.jetbrains.com/updates/updates.xml'
    $downloadUrl = 'https://download.jetbrains.com/webstorm/WebStorm-$($version).exe'

    [xml] $updates = (New-Object System.Net.WebClient).DownloadString($releasesUrl)
    $versionInfo = $updates.products.product `
    | Where-Object { $_.name -eq $productName } `
    | ForEach-Object { $_.channel } | Where-Object { $_.id -eq 'WS_Release' } `
    | ForEach-Object { $_.build } `
    | Sort-Object { [version] $_.number } `
    | Select-Object -Last 1

    $version = $versionInfo.Version

    if ($versionInfo.ReleaseDate) {
        $fullVersionNumber = "$($versionInfo.Version).$($versionInfo.ReleaseDate)"
    }
    else {
        $fullVersionNumber = "$($versionInfo.Version)"
    }

    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    return @{ Url32 = $downloadUrl; Version = $fullVersionNumber }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion