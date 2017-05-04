param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $relasePageUrl = 'http://www.7-zip.org/'
    $executableRegEx = 'x64\.exe$'
    $versionRegEx = 'Download\s7\-Zip\s([0-9\.]+)'
    $urlPrefix = 'http://www.7-zip.org'

    $releasePage = Invoke-WebRequest $relasePageUrl -UseBasicParsing
    $version = ([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)
    $url = $releasePage.links | Where-Object href -match $executableRegEx | Select-Object -First 1 -Expand Href

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = "$urlPrefix/$url"; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')