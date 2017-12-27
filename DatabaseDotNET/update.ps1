param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'http://fishcodelib.com/Database_new.htm'
    $url = 'http://fishcodelib.com/files/DatabaseNet4.zip'
    $versionRegEx = 'Ver ([0-9\.]+)'

    $releasePage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $releasePage.Content -match $versionRegEx
    $version = $matches[1]

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')