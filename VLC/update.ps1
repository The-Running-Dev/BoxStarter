param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://www.videolan.org/vlc/download-windows.html'
    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $re = 'win64.*\.exe$'
    $url = $releasePage.Links | Where-Object href -match $re | ForEach-Object href
    $version = $url -Split '-' | Select-Object -Last 1 -Skip 1

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = "http:$url"; Version = $version; }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')