param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://notepad-plus-plus.org'
    $versionRegEx = 'download/v([0-9\.]+).html'
    $downloadUrlRegEx = 'npp\.([0-9\.]+)\.Installer.x64.exe'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $downloadPageUrl = $releasePage.links | Where-Object href -match $versionRegEx | Select-Object -First 1 -Expand href
    $version = $matches[1]

    $downloadPage = Invoke-WebRequest -Uri "$releaseUrl/$downloadPageUrl" -UseBasicParsing
    $downloadPartialUrl = $downloadPage.links | Where-Object href -match $downloadUrlRegEx | Select-Object -First 1 -Expand href

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = "$releaseUrl$downloadPartialUrl"; Version = $version }
}

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.end.ps1')