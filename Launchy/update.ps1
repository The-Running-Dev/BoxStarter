param([switch] $force, [switch] $push)

$originalLocation = Get-Location
$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\_Scripts\update.begin.ps1')

function global:au_GetLatest {
    $version = '2.6.2.1'

    if ($force) {
        $global:au_Version = $version
    }

    return @{
        Url32 = 'http://launchy.net/downloads/win/LaunchySetup2.6B2.exe'
        Version = $version
    }
}

. (Join-Path $PSScriptRoot '..\_Scripts\update.end.ps1')