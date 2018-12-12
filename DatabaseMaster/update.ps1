param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'http://nucleonsoftware.com/downloads'
    $url = 'http://nucleonsoftware.com/download/DatabaseMasterSetup.msi'
    $versionRegEx = 'Database Master.*?Version: ([0-9\.]+)'

    $releasePage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $versionString = Select-String '<li>Version: [0-9\.]+' -input $releasePage.Content -AllMatches  | ForEach {$_.matches.Value } | select -skip 2 -First 1
    $versionString -match '[0-9\.]+'
    $version = $matches[0]

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')