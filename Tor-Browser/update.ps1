param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $rootUrl = 'https://www.torproject.org'
    $releaseUrl = "$rootUrl/projects/torbrowser.html"
    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $url = $releasePage.Links | Where-Object href -Match 'torbrowser-install.*en-US\.exe$' | Select-Object -First 1 -Expand href
    $url = $url -Replace '\.\.', $rootUrl
    $version = $url -Split '\/' | Select-Object -Last 1 -Skip 1

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')