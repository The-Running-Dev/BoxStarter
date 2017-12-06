param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://octopus.com/downloads'
    $versionRegEx = 'Version: ([0-9\.]+)'
    $url = 'https://download.octopusdeploy.com/octopus/Octopus.$version-x64.msi'

    $downloadPage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $version = [regex]::match($downloadPage, $versionRegEx).Groups[1].Value
    $downloadEndPointUrl = $downloadPage.Links | Where-Object href -match $downloadEndPointLinkRegEx | Select-Object -First 1 -Expand href
    $url = $ExecutionContext.InvokeCommand.ExpandString($url)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')