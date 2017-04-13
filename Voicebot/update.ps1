param([switch] $force)

. (Join-Path $PSScriptRoot '..\Build\update.begin.ps1')

function global:au_GetLatest {
    $downloadEndPoint = 'https://www.binaryfortress.com/Data/Download/?package=voicebot&log=123'
    $versionRegEx = 'VoiceBotSetup\-([0-9\.\-]+)\.exe$'

    $downloadUrl = ((Get-WebURL -Url $downloadEndPoint).ResponseUri).AbsoluteUri
    $version = ([regex]::match($downloadUrl, $versionRegEx).Groups[1].Value)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Build\update.end.ps1')