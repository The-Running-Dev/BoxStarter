param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://handbrake.fr/downloads2.php'
    $versionRegEx = 'Current Version: ([0-9\.]+)'
    $downloadUrl = 'https://download2.handbrake.fr/$version/HandBrakeCLI-$version-win-x86_64.zip'

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
