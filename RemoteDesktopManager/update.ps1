param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://remotedesktopmanager.com/Home/Download'
    $versionRegEx = 'Version ([0-9\.]+)'
    $downloadPageUrl = 'https://remotedesktopmanager.com/Home/ThankYou?f=RDMsetup'
    $downloadUrlRegEx = 'Setup\.RemoteDesktopManager\..*\.exe'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $releasePage.Content -match $versionRegEx
    $version = $matches[1]

    $downloadPage = Invoke-WebRequest -Uri $downloadPageUrl -UseBasicParsing
    $url = $downloadPage.Links | Where-Object href -match $downloadUrlRegEx | Select-Object -First 1 -ExpandProperty href

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')