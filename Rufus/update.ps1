param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://rufus.akeo.ie/'
    $versionRegEx = 'Version ([0-9\.]+)'
    $downloadUrlPrefix = 'https://rufus.akeo.ie'
    $downloadUrlRegEx = '\.exe'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = [version]([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)
    $partialUrl = $releasePage.Links | Where-Object href -match $downloadUrlRegEx | Select-Object -First 1 -Expand href
    $url = "$downloadUrlPrefix$partialUrl"

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')