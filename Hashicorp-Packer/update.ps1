param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://www.packer.io/downloads.html'
    $versionRegEx = '\(([0-9\.]+)\)'
    $downloadUrlRegEx = 'windows_amd64.zip'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = [regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value
    $url = $releasePage.links | Where-Object href -match $downloadUrlRegEx | Select-Object -First 1 -Expand Href

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.end.ps1')