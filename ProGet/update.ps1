param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'http://inedo.com/proget/versions'
    $downloadUrlPrefix = 'http://inedo.com'
    $downloadUrlText = 'Full Installer'
    $versionRegEx = '([0-9\.]+)'

    $downloadPage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $downloadEndPointUrl = $downloadPage.links | Where-Object outerHTML -match $downloadUrlText | Select-Object -First 1 -Expand Href
    $version = ([regex]::match($downloadEndPointUrl, $versionRegEx).Groups[1].Value)
    $url = Get-RedirectUrl "$downloadUrlPrefix$downloadEndPointUrl"

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')