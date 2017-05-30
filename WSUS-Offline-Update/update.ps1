param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'http://www.wsusoffline.net/'
    $downloadUrl = 'http://download.wsusoffline.net/'
    $versionRegEx = 'Version ([0-9\.]+) released'
    $downloadUrlRegEx = 'wsusoffline\d+.zip'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = [regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value

    $downloadPage = Invoke-WebRequest -Uri $downloadUrl -UseBasicParsing
    $url = $downloadPage.links | Where-Object href -match $downloadUrlRegEx | Select-Object -First 1 -Expand Href

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')