param([switch] $force, [switch] $push)

$originalLocation = Get-Location
$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://technet.microsoft.com/en-us/library/mt592918.aspx'
    $downloadUrl = 'https://www.microsoft.com/en-us/download/confirmation.aspx?id=49117'
    $versionRegEx = 'Version ([0-9]+) \(Build ([0-9\.]+)\)'
    $installerRegEx = 'officedeploymenttool_([0-9\-]+).exe'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $versionInfo = $releasePage.Content -match $versionRegEx
    $version = "$($matches[1]).$($matches[2])"

    if ($force) {
        $global:au_Version = $version
    }

    $downloadPage = Invoke-WebRequest -Uri $downloadUrl -UseBasicParsing
    $url = $downloadPage.Links | Where-Object href -match $installerRegEx | Select-Object -First 1 -Expand href

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')