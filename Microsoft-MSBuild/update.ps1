param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.onchange.begin.ps1')

function global:au_GetLatest {
    $version = '1.0'

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')