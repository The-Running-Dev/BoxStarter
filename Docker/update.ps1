param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $url = 'https://download.docker.com/win/stable/Docker for Windows Installer.exe'
    $version = Get-MatchingTextFromUrl 'https://docs.docker.com/docker-for-windows/release-notes/' 'Community Edition ([0-9\.]+)'

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')