param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

$getBetaVersion = $true

function global:au_GetLatest {
    $stableVersionDownloadUrl = 'https://www.binaryfortress.com/Data/Download/?package=clipboardfusion&log=104'
    $stableVersionRegEx = 'ClipboardFusionSetup-([0-9\.\-]+)\.exe$'

    $betaVersionDownloadUrl = 'https://www.binaryfortress.com/Data/Download/?package=clipboardfusion&beta=1&log=104'
    $betaVersionRegEx = '.*ClipboardFusionSetup-([0-9\.\-]+)-Beta([0-9]+).*'

    if ($getBetaVersion) {
        $betaVersionDownloadUrl = ((Get-WebURL -Url $betaVersionDownloadUrl).ResponseUri).AbsoluteUri
        $betaVersion = $($betaVersionDownloadUrl -replace $betaVersionRegEx, '$1.$2')

        if ($force) {
            $global:au_Version = $betaVersion
        }

        return @{ Url32 = $betaVersionDownloadUrl; Version = $betaVersion }
    }

    $stableVersionDownloadUrl = ((Get-WebURL -Url $stableVersionDownloadUrl).ResponseUri).AbsoluteUri
    $stableVersion = [regex]::match($stableVersionDownloadUrl, $stableVersionRegEx).Groups[1].Value

    if ($force) {
        $global:au_Version = $stableVersion
    }

    return @{ Url32 = $stableVersionDownloadUrl; Version = $stableVersion }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')