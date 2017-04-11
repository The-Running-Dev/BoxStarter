. (Join-Path $PSScriptRoot '..\Build\update.common.ps1')

function global:au_GetLatest {
    $releasesUrl = 'https://nodejs.org/en/download/current/'
    $versionRegEx = 'node-v(.+)-x64.msi'

    $downloadPage = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing
    $url = $downloadPage.links | Where-Object href -match $versionRegEx | Select-Object -First 1 -Expand href
    $version = $matches[1]

    return @{ Url32 = $url; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion