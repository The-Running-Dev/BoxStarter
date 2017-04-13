param([switch] $force)

. (Join-Path $PSScriptRoot '..\Build\update.begin.ps1')

function global:au_GetLatest {
    $release = Get-GitHubVersion 'gitextensions/gitextensions' '.*SetupComplete\.msi$'

    if ($force) {
        $global:au_Version = $release.Version
    }

    return @{ Url32 = $release.DownloadUrl; Version = $release.Version }
}

. (Join-Path $PSScriptRoot '..\Build\update.end.ps1')