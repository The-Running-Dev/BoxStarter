param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadPageUrl = 'https://github.com/moby/moby/releases'
    $downloadUrl = 'https://download.docker.com/win/edge/InstallDocker.msi'
    $release = Get-GitHubVersion 'moby/moby'
    $version = $release.Version -replace '-ce', ''

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')