param([switch] $force, [switch] $push)

$originalLocation = Get-Location
$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\_Scripts\update.begin.ps1')

function global:au_GetLatest {
    $version = '0.9.98'

    if ($force) {
        $global:au_Version = $version
    }

    return @{
        Url32 = 'https://downloads.sourceforge.net/project/kdiff3/kdiff3/0.9.98/KDiff3-64bit-Setup_0.9.98-2.exe';
        Version = $version
    }
}

. (Join-Path $PSScriptRoot '..\_Scripts\update.end.ps1')