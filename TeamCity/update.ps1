param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadUrl = 'https://download.jetbrains.com/teamcity/TeamCity-$version.tar.gz'
    $downloadEndPointUrl = 'https://www.jetbrains.com/teamcity/download/download-thanks.html?platform=windows'
    $downloadLink = Invoke-WebRequest -Uri $downloadEndPointUrl -UseBasicParsing `
        | Select-Object -Expand links | Where-Object { $_.href -match '.*download\?code=TC' } `
        | Select-Object -First 1 -ExpandProperty href
    $downloadLink = "http:$downloadLink&platform=windows"

    $downloadUrl = Get-RedirectUrl $downloadLink
    $version = Get-String $downloadUrl '.*TeamCity\-([0-9\.]+)\.exe'

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')