param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadUrl = 'https://download.jetbrains.com/teamcity/TeamCity-$version.exe'
    $downloadEndPointUrl = 'http://data.services.jetbrains.com/products/download?code=TC&platform=windows'
    $downloadLinkRegEx = '.*TeamCity\-([0-9\.]+)\.exe'

    $downloadUrl = Get-RedirectUrl $downloadEndPointUrl
    $version = Get-String $downloadUrl $downloadLinkRegEx

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')
