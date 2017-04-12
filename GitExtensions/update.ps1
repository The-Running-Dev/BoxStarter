. (Join-Path $PSScriptRoot '..\Build\update.begin.ps1')

function global:au_GetLatest {
    $release = Get-GitHubVersion 'gitextensions/gitextensions' '.*SetupComplete\.msi$'

    return @{ Url32 = $release.DownloadUrl; Version = $release.Version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion