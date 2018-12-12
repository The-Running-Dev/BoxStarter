param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://fishcodelib.com/Database.htm'
    $url = 'https://fishcodelib.com/files/DatabaseNet4.zip'
    $versionRegEx = 'Free and Plus Edition ([0-9\.]+).*(\d{4})'

    $releasePage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $releasePage.Content -match $versionRegEx
    $version = "$($matches[1]).$($matches[2])"

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')