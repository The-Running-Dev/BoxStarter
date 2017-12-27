param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $url = 'https://downloads.sourceforge.net/project/dfendreloaded/D-Fend%20Reloaded/D-Fend%20Reloaded%201.4.4/D-Fend-Reloaded-1.4.4-Setup.exe'
    $version = '1.4.4'

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')