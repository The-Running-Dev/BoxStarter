param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadEndPointUrl = 'https://www.visualstudio.com/thank-you-downloading-visual-studio/?sku=BuildTools&rel=15'
    $releaseUrl = 'https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools'
    $versionRegEx = '(15\.[0-9\.]+)'
    $downloadRegEx = '.*(https\:.*/vs_BuildTools.exe)'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $releasePage.Content -match $versionRegEx
    $version = $matches[1]

    $downloadPage = Invoke-WebRequest -Uri $downloadEndPointUrl -UseBasicParsing
    $downloadPage.Content -match $downloadRegEx
    $url = $matches[1]

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version; }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')