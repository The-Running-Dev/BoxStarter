param([switch] $force, [switch] $push)

$originalLocation = Get-Location
$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $gitHubRepository = 'git-for-windows/git'
    $downloadUrlRegEx = '.*Git\-([0-9\.]+)\-64\-bit.exe'
    $versionRegEx = '([0-9\.]+)\..*'

    $release = Get-GitHubVersion $gitHubRepository $downloadUrlRegEx
    $version = [regex]::match($release.Version, $versionRegEx).Groups[1].Value

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $release.DownloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')