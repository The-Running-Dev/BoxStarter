. (Join-Path $PSScriptRoot '..\Build\update.common.ps1')

function global:au_GetLatest {
    $downloadEndPoint = 'https://www.binaryfortress.com/Data/Download/?package=voicebot&log=123'
    $versionRegEx = 'VoiceBotSetup\-([0-9\.\-]+)\.exe$'

    $downloadUrl = ((Get-WebURL -Url $downloadEndPoint).ResponseUri).AbsoluteUri
    $version = ([regex]::match($downloadUrl, $versionRegEx).Groups[1].Value)

    return @{ Url32 = $downloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion