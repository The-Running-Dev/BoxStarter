param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot
$setupDir = Join-Path $packageDir 'Setup'
$setupFiles = Join-Path $PSScriptRoot '..\..\..\BoxStarter\Installers\Office365Business' -Resolve

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_BeforeUpdate {
    if (-not (Test-Path "$setupDir\setup.exe")) {
        New-Item -ItemType Directory $setupDir
        Copy-Item -Recurse $setupFiles\* $setupDir\
        New-Item -ItemType File "$setupDir\setup.exe.ignore"
    }
}

function global:au_GetLatest {
    $releaseUrl = 'https://support.office.com/en-us/article/Version-and-build-numbers-of-update-channel-releases-ae942449-1fca-4484-898b-a933ea23def7?ui=en-US&rs=en-US&ad=US'
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