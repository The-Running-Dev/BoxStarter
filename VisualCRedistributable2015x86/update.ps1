param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $version = '14.0.24215.20160928'

    if ($force) {
        $global:au_Version = $version
    }

    return @{
        Url32 = 'https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x86.exe';
        Version = $version
    }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')