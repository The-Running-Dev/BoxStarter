param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $release = Get-GitHubVersion 'atom/atom' '.*AtomSetup\-x64\.exe$'

    if ($force) {
        $global:au_Version = $release.Version
    }

    return @{ Url32 = $release.DownloadUrl; Version = $release.Version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')