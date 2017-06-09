param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.begin.ps1')

function global:au_GetLatest {
    $release = Get-GitHubVersion 'Maximus5/ConEmu' '.*ConEmuSetup.([0-9]+).exe$'

    if ($force) {
        $global:au_Version = $release.Version
    }

    return @{ Url32 = $release.DownloadUrl; Version = $release.Version }
}

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.end.ps1')