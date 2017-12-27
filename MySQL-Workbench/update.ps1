param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://dev.mysql.com/downloads/workbench/'
    $versionRegEx = 'MySQL Workbench ([0-9\.]+)'
    $downloadPageUrlPrefix = 'https://dev.mysql.com'
    $downloadPageRegEx = 'downloads/file/\?id=([0-9\.]+)'
    $downloadUrlRegEx = 'mysql\-workbench\-community\-([0-9\.]+)\-winx64\.msi'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = ([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)
    $downloadEndpointUrl = $releasePage.Links | Where-Object href -match $downloadPageRegEx | Select-Object -First 1 -Expand href

    $downlaodPageUrl = "$downloadPageUrlPrefix$downloadEndpointUrl"
    $downloadPage = Invoke-WebRequest -Uri $downlaodPageUrl -UseBasicParsing
    $url = $downloadPage.Links | Where-Object href -match $downloadUrlRegEx | Select-Object -First 1 -Expand href
    $url = "$downloadPageUrlPrefix$url"

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')