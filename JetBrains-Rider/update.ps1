param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releasesUrl = 'https://data.services.jetbrains.com/products/releases?code=RD&latest=true&type=release'

    $releases = (Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing).Content | ConvertFrom-Json
    $version = $releases.RD.Version
    $url = $releases.RD.Downloads.Windows.Link
    $checksum = (Invoke-WebRequest -Uri $releases.RD.Downloads.Windows.ChecksumLink -UseBasicParsing).Content -replace '(\w+).*', '$1'

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version; Checksum32 = $checksum }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')