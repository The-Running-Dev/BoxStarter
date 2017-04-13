param([switch] $force)

. (Join-Path $PSScriptRoot '..\Build\update.begin.ps1')

function global:au_GetLatest {
    $gitHubRepository = 'git-for-windows/git'
    $downloadUrlRegEx = '.*Git\-([0-9\.]+)\-64\-bit.exe'
    $versionRegEx = '([0-9\.]+)\..*'

    $release = Get-GitHubVersion $gitHubRepository $downloadUrlRegEx
    $version = $release.Version -replace $versionRegEx, '$1'

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $release.DownloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Build\update.end.ps1')