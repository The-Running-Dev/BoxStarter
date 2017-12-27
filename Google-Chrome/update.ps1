param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'http://www.filehorse.com/download-google-chrome-64/'
    $downloadUrl = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi'
    $versionRegEx = '.*Google Chrome ([0-9\.]+) \(64\-bit\)'

    $releaseHtml = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $version = [regex]::match($releaseHtml.Content, $versionRegEx).Groups[1].Value

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')