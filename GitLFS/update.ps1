param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $gitHubRepository = 'git-lfs/git-lfs'
    $downloadUrlRegEx = '.*git-lfs-windows-([0-9\.]+)\.exe'

    $release = Get-GitHubVersion $gitHubRepository $downloadUrlRegEx
    $version = $release.Version

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $release.DownloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')