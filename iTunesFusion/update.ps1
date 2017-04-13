param([switch] $force)

. (Join-Path $PSScriptRoot '..\Build\update.begin.ps1')

function global:au_GetLatest {
    $downloadEndPointUrl = 'https://www.binaryfortress.com/Data/Download/?package=itunesfusion&log=102'
    $versionRegEx = '.*iTunesFusionSetup-([0-9\.\-]+)\.exe$'

    $downloadUrl = ((Get-WebURL -Url $downloadEndPointUrl).ResponseUri).AbsoluteUri
    $version = $($downloadUrl -replace $versionRegEx, '$1')

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Build\update.end.ps1')