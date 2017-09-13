param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://www.microsoft.com/net/download/core'
    $downloadLinkRegEx = '\.exe download'
    $versionRegEx = 'dotnet\-sdk-([0-9\.]+)\-win-x64\.exe'

    $downloadPage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $downloadLink = $downloadPage.Links | Where-Object outerHTML -match $downloadLinkRegEx | Select-Object -First 1 -Expand href

    $url = ((Get-WebURL -Url $downloadLink).ResponseUri).AbsoluteUri
    $version = [regex]::match($url, $versionRegEx).Groups[1].Value

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.end.ps1')