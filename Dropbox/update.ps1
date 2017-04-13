param([switch] $force)
. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

$getBetaVersion = $false

function global:au_GetLatest {
    $stableVersionDownloadUrl = 'https://www.dropbox.com/download?full=1&plat=win'
    $stableVersionRegEx = '.*Dropbox%20([0-9\.]+).*'

    $betaVersionReleasePageUri = 'https://www.dropboxforum.com/t5/Desktop-client-builds/bd-p/101003016'
    $betaVersionDownloadUrl = 'https://clientupdates.dropboxstatic.com/client/Dropbox%20$($betaVersion)%20Offline%20Installer.exe'
    $betaVersionRegEx = '.*Beta-Build-([0-9\.\-]+).*'

    if ($getBetaVersion) {
        $betaVersion = ((Get-FirstBetaLink $betaVersionReleasePageUri $betaVersionRegEx) -replace $betaVersionRegEx, '$1') -replace '-', '.'
        $betaVersionDownloadUrl = $ExecutionContext.InvokeCommand.ExpandString($betaVersionDownloadUrl)

        if ($force) {
            $global:au_Version = $betaVersion
        }

        return @{ Url32 = $betaVersionDownloadUrl; Version = $betaVersion }
    }

    $stableVersionDownloadUrl = ((Get-WebURL -Url $stableVersionDownloadUrl).ResponseUri).AbsoluteUri
    $stableVersion = [regex]::match($stableVersionDownloadUrl, $versionRegEx).Groups[1].Value

    if ($force) {
        $global:au_Version = $stableVersion
    }

    return @{ Url32 = $stableVersionDownloadUrl; Version = $stableVersion }
}

function Get-FirstBetaLink([string] $uri, [string] $regEx) {
    $html = Invoke-WebRequest -UseBasicParsing -Uri $uri

    return $html.links | Where-Object { $_.href -match $regEx } | Select-Object -First 1
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')