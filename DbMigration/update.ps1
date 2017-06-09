param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'http://fishcodelib.com/DBMigration.htm'
    $url = 'http://fishcodelib.com/files/DBMigration.zip'
    $versionRegEx = 'Version ([0-9\.]+).*([0-9\.]+)'

    $releasePage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $releasePage.Content -match $versionRegEx
    $version = "$($matches[1]).$($matches[2])"

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.end.ps1')