param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://www.filehorse.com/download-ultravnc-64/'
    $downloadUrl = 'https://www.filehorse.com/download-ultravnc-64/download/'
    $versionRegEx = '.*UltraVNC ([0-9\.]+)'
    $executableRegEx = 'UltraVNC.*\.exe'

    $releasePage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $version = $releasePage.Content -match $versionRegEx | ForEach-Object { $matches[1] }

    $downloadPage = Invoke-WebRequest -UseBasicParsing -Uri $downloadUrl
    $url = $downloadPage.Links | Where-Object href -match $executableRegEx | Select-Object -First 1 -Expand Href

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')