param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadEndpointUrl = 'https://evernote.com/download/get.php?file=Win'
    $versionRegEx = 'Evernote_([0-9\.]+).exe'

    $url = Get-RedirectUrl $downloadEndpointUrl
    $version = ([regex]::match($url, $versionRegEx).Groups[1].Value)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.end.ps1')