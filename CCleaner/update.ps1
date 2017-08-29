param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.begin.ps1')

function global:au_GetLatest {
    $relasePageUrl = 'https://www.piriform.com/ccleaner/version-history'
    $downloadPageUrl = 'https://www.piriform.com/ccleaner/download/standard'
    $executableRegEx = '\.exe$'
    $versionRegEx = '\<h6\>v((?:[\d]\.)[\d\.]+)'

    try { $releasePage = Invoke-WebRequest $relasePageUrl -UseBasicParsing } catch {}
    $version = ([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)

    $downloadPage = Invoke-WebRequest -Uri $downloadPageUrl -UseBasicParsing -ErrorAction SilentlyContinue
    $url = $downloadPage.links | Where-Object href -match $executableRegEx | Select-Object -First 1 -expand href

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.end.ps1')