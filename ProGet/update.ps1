param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'http://inedo.com/proget/download'
    $downloadUrlPrefix = 'http://inedo.com'
    $downloadUrlText = 'Download ProGet Installer'
    $versionRegEx = 'Latest Version:\s([0-9\.\-]+)'

    $downloadPage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = ([regex]::match($downloadPage.Content, $versionRegEx).Groups[1].Value)
    $downloadEndPointUrl = $downloadPage.links | Where-Object outerHTML -match $downloadUrlText | Select-Object -First 1 -Expand Href
    $url = Get-RedirectUrl "$downloadUrlPrefix$downloadEndPointUrl"

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')