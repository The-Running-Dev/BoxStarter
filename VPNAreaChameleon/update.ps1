param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $version = '1.0.47.277'
    $url = 'https://vpnarea.com/VPNAreaChameleon.exe'

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version; }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')