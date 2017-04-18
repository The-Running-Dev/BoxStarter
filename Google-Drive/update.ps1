param([switch] $force, [switch] $push)

$originalLocation = Get-Location
$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\_Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'http://www.filehorse.com/download-google-drive/'
    $downloadUrl = 'https://dl.google.com/drive/gsync_enterprise.msi'
    $versionRegEx = '.*Google Drive ([0-9\.]+)'

    $releaseHtml = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $version = [regex]::match($releaseHtml.Content, $versionRegEx).Groups[1].Value

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\_Scripts\update.end.ps1')