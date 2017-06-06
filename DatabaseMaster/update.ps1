param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'http://nucleonsoftware.com/downloads'
    $url = 'http://nucleonsoftware.com/download/DatabaseMasterSetup.msi'
    $versionRegEx = @"
Download Database Master.*
<ul>
<li>Version: ([0-9\.]+)
"@

    $releasePage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $releasePage.Content -match $versionRegEx
    $version = $matches[1]

    write-host $($releasePage.Content -match $versionRegEx)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')