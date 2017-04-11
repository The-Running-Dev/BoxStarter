. (Join-Path $PSScriptRoot '..\Build\update.common.ps1')

function global:au_GetLatest {
    $gitHubRepository = 'git-for-windows/git'
    $downloadUrlRegEx = '.*Git\-([0-9\.]+)\-64\-bit.exe'
    $versionRegEx = '([0-9\.]+)\..*'

    $release = Get-GitHubVersion $gitHubRepository $downloadUrlRegEx

    return @{ Url32 = $release.DownloadUrl; Version = $release.Version -replace $versionRegEx, '$1' }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion