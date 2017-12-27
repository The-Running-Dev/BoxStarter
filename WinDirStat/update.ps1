param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://windirstat.net/download.html'
    $versionRegEx = 'Download WinDirStat ([0-9\.\-]+)'
    $downloadPermaLink = 'https://windirstat.net/wds_current_setup.exe'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = ([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)

    $url = ((Get-WebURL -Url $downloadPermaLink).ResponseUri).AbsoluteUri

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')