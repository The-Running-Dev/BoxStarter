param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadPageUrl = 'http://filehippo.com/download_utorrent/'
    $versionRegEx = 'uTorrent ([0-9\.]+) Build (\d+)'
    $url = 'http://download.ap.bittorrent.com/track/stable/endpoint/utorrent/os/windows'
    $fileName32 = 'uTorrent.exe'

    $downloadPage = Invoke-WebRequest $downloadPageUrl -UseBasicParsing
    $matches = [regex]::match($downloadPage.Content, $versionRegEx)
    $version = [version]"$($matches.Groups[1].Value).$($matches.Groups[2].Value)"

    return @{ Url32 = $url; Version = $version; FileName32 = $fileName32; FileType = 'exe' }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')