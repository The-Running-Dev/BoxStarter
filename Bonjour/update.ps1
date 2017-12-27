param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')
function global:au_GetLatest {
    $downloadPageUrl = 'https://support.apple.com/kb/DL999?viewlocale=en_US&locale=en_US'
    $versionRegEx = 'v([0-9\.]+)'
    $downloadUrlRegEx = '"metaUrl": "(.*\.exe)"'

    $downloadPage = Invoke-WebRequest $downloadPageUrl -UseBasicParsing
    $version = ([regex]::match($downloadPage.Content, $versionRegEx).Groups[1].Value)
    $url = ([regex]::match($downloadPage.Content, $downloadUrlRegEx).Groups[1].Value)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')