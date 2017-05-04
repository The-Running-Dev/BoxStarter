param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://www.apple.com/itunes/download/'
    $downloadPage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing

    $downloadPage.Content -match "\<iframe src=`"([^`"]+)`"[^\>\/]+title=`"Please select a download" | Out-Null
    $iframeLink = $Matches[1]
    $matches = $null

    $downloadPage = Invoke-WebRequest -Uri $iframeLink -UseBasicParsing
    $downloadPage.Content -match "[`"'](https:\/\/[^`"']+iTunes64Setup\.exe)[`"']" | Out-Null
    $downloadUrl = $Matches[1]
    $matches = $null

    $re = "[`"']iTunes ([\d\.]+) for Windows"
    $downloadPage.Content -match $re

    if ($matches) {
        $version = $Matches[1]
    }

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')