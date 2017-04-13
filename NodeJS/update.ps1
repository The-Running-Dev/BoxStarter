param([switch] $force)

. (Join-Path $PSScriptRoot '..\Build\update.begin.ps1')

function global:au_GetLatest {
    $releasesUrl = 'https://nodejs.org/en/download/current/'
    $versionRegEx = 'node-v(.+)-x64.msi'

    $downloadPage = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing
    $url = $downloadPage.links | Where-Object href -match $versionRegEx | Select-Object -First 1 -Expand href
    $version = $matches[1]

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Build\update.end.ps1')