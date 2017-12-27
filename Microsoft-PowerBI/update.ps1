param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://www.microsoft.com/en-us/download/details.aspx?id=45331'
    $downloadUrl = 'https://www.microsoft.com/en-us/download/confirmation.aspx?id=45331'
    $versionRegEx = 'Version:.*?([0-9\.]+)'
    $installerRegEx = 'PBIDesktop_x64.msi'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = ([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)

    if ($force) {
        $global:au_Version = $version
    }

    $downloadPage = Invoke-WebRequest -Uri $downloadUrl -UseBasicParsing
    $url = $downloadPage.Links | Where-Object href -match $installerRegEx | Select-Object -First 1 -Expand href

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')