param([switch] $force)

. (Join-Path $PSScriptRoot '..\Build\update.begin.ps1')

function global:au_GetLatest {
    $version = '1.0.47.277'

    if ($force) {
        $global:au_Version = $version
    }

    return @{
        Url32 =  'http://vpnarea.com/VPNAreaChameleon.exe';
        Version = $version
    }
}

. (Join-Path $PSScriptRoot '..\Build\update.end.ps1')