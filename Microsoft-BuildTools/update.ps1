param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadEndPointUrl = 'https://www.visualstudio.com/thank-you-downloading-visual-studio/?sku=BuildTools&rel=15'
    $releaseUrl = 'https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools'
    $versionRegEx = '(15\.[0-9\.]+)'
    $downloadRegEx = '(https://download.microsoft.com.*/vs_BuildTools.exe)'
    $fileName32 = 'Microsoft-Build-Tools.7z'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $releasePage.Content -match $versionRegEx
    $version = $matches[1]

    $downloadPage = Invoke-WebRequest -Uri $downloadEndPointUrl -UseBasicParsing
    $downloadPage.Content -match $downloadRegEx
    $url = $matches[1]

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version; FileName32 = $fileName32 }
}

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.end.ps1')