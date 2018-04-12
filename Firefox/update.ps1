param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadEndpointUrl = 'https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-US'
    $versionRegEx = 'releases/([0-9\.]+)/'

    $url = Get-RedirectUrl $downloadEndpointUrl
    $version = ([regex]::match($url, $versionRegEx).Groups[1].Value)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')