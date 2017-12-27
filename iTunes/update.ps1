param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://www.apple.com/itunes/download/'
    $versionRegEx = 'iTunes ([0-9\.]+)'
    $downloadUrlRegEx = 'iTunes64Setup.exe'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = [regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value
    $url = $releasePage.Links | Where-Object href -match $downloadUrlRegEx | Select-Object -First 1 -Expand Href

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')