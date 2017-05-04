param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'http://danhinsley.com/metax/metax.html'
    $versionRegEx = 'DOWNLOAD&nbsp;MetaX&nbsp;V([0-9\.]+)'
    $url = 'http://www.danhinsley.com/downloads/MetaXSetup.msi'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = ([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Version = $version; Url32 = $url }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')