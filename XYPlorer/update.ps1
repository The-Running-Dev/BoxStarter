param([switch] $force, [switch] $push)

$originalLocation = Get-Location
$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\_Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://www.xyplorer.com/download.php'
    $versionRegEx = '([0-9\.]+), released'
    $downloadUrl = 'https://www.xyplorer.com/download/xyplorer_full_noinstall.zip'

    $releasePage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $version = [version]([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\_Scripts\update.end.ps1')