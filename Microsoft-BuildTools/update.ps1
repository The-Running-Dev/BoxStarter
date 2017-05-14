param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadEndPointUrl = 'https://www.visualstudio.com/thank-you-downloading-visual-studio/?sku=BuildTools&rel=15'
    $releaseUrl = 'https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools'
    $versionRegEx = '(15\.[0-9\.]+)'
    $downloadRegEx = 'var downloadUrl = "(.*/vs_BuildTools.exe)'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = ([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)

    $downloadPage = Invoke-WebRequest -Uri $downloadEndPointUrl -UseBasicParsing
    $url = ([regex]::match($downloadPage.Content, $downloadRegEx).Groups[1].Value)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Version = $version; Url32 = $url }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')