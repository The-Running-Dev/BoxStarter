param([switch] $force, [switch] $push)

$originalLocation = Get-Location
$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\_Scripts\update.begin.ps1')

function global:au_GetLatest {
    $version = '14.0.24215.20160928'

    if ($force) {
        $global:au_Version = $version
    }

    return @{
        Url32 = 'https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x64.exe';
        Version = $version
    }
}

. (Join-Path $PSScriptRoot '..\_Scripts\update.end.ps1')