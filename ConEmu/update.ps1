. (Join-Path $PSScriptRoot '..\Build\update.common.ps1')

function global:au_GetLatest {
    $release = Get-GitHubVersion 'Maximus5/ConEmu' '.*ConEmuSetup.([0-9]+).exe$'

    return @{ Url32 = $release.DownloadUrl; Version = $release.Version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion