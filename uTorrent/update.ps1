param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadPageUrl = 'http://www.utorrent.com/downloads/win'
    $versionRegEx = 'Stable\(([0-9\.]+) build (\d+)\)'
    $url = 'http://download.ap.bittorrent.com/track/stable/endpoint/utorrent/os/windows'
    $fileName32 = 'uTorrent.exe'

    $downloadPage = Invoke-WebRequest $downloadPageUrl -UseBasicParsing
    $matches = [regex]::match($downloadPage.Content, $versionRegEx)
    $version = [version]"$($matches.Groups[1].Value).$($matches.Groups[2].Value)"

    return @{ Url32 = $url; Version = $version; FileName32 = $fileName32; FileType = 'exe' }
}

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.end.ps1')