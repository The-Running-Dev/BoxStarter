param([switch] $force)

. (Join-Path $PSScriptRoot '..\Build\update.begin.ps1')

function global:au_GetLatest {
    $releasesUrl = 'http://www.filehorse.com/download-google-drive/'
    $downloadUrl = 'https://dl.google.com/drive/gsync_enterprise.msi'
    $versionRegEx = '.*Google Drive ([0-9\.]+)'

    $html = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl

    $version = [regex]::match($html.Content, $versionRegEx).Groups[1].Value

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Build\update.end.ps1')