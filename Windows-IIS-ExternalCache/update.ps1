param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $version = '1.1.20151123'

    if ($force) {
        $global:au_Version = $version
    }

    return @{
        Url32 = 'http://download.microsoft.com/download/C/A/5/CA5FAD87-1E93-454A-BB74-98310A9C523C/ExternalDiskCache_amd64.msi';
        Version = $version
    }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')