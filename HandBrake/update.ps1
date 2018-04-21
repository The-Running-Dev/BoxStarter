param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://handbrake.fr/downloads.php'
    $versionRegEx = 'Current Version: ([0-9\.]+)'
    $downloadUrl = 'https://download.handbrake.fr/releases/$version/HandBrake-$version-x86_64-Win_GUI.exe'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $releasePage.Content -match $versionRegEx
    $version = [version]$matches[1]
    $url = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')
