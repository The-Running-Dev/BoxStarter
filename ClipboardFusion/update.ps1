. (Join-Path $PSScriptRoot '..\update.common.ps1')

$getBetaVersion = $true

function global:au_GetLatest {
    $stableVersionDownloadUrl = 'https://www.binaryfortress.com/Data/Download/?package=clipboardfusion&log=104'
    $stableVersionRegEx = '.*ClipboardFusionSetup-([0-9\.\-]+)\.exe$'

    $betaVersionDownloadUrl = 'https://www.binaryfortress.com/Data/Download/?package=clipboardfusion&beta=1&log=104'
    $betaVersionRegEx = '.*ClipboardFusionSetup-([0-9\.\-]+)-Beta([0-9]+).*'

    if ($getBetaVersion) {
        $betaVersionDownloadUrl = ((Get-WebURL -Url $betaVersionDownloadUrl).ResponseUri).AbsoluteUri
        $betaVersion = $($betaVersionDownloadUrl -replace $betaVersionRegEx, '$1.$2')

        return @{ Url32 = $betaVersionDownloadUrl; Version = $betaVersion }
    }

    $stableVersionDownloadUrl = ((Get-WebURL -Url $stableVersionDownloadUrl).ResponseUri).AbsoluteUri
    $stableVersion = $($stableVersionDownloadUrl -replace $stableVersionRegEx, '$1')

    return @{ Url32 = $stableVersionDownloadUrl; Version = $stableVersion }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion