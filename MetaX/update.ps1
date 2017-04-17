param([switch] $force, [switch] $push)

$originalLocation = Get-Location
$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'http://danhinsley.com/metax/metax.html'
    $versionRegEx = 'DOWNLOAD&nbsp;MetaX&nbsp;V([0-9\.]+)'
    $downloadUrlRegEx = '\.exe'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = ([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)
    $url = $releasePage.Links | Where-Object href -match $downloadUrlRegEx | Select-Object -First 1 -Expand href

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Version = $version; Url32 = $url }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')