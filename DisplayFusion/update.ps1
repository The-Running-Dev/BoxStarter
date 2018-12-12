param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadEndPointUrl = 'https://www.binaryfortress.com/Data/Download/?package=displayfusion&beta=1&log=101'
    $changeLogUrl = 'https://www.displayfusion.com/ChangeLog/Beta/'
    $versionRegEx = 'v([0-9\.]+)\sBeta\s(\d+)'

    $downloadUrl = ((Get-WebURL -Url $downloadEndPointUrl).ResponseUri).AbsoluteUri

    $changeLogPage = Invoke-WebRequest -UseBasicParsing -Uri $changeLogUrl
    $changeLogPage.Content -match $versionRegEx
    $version = "$($matches[1]).$($matches[2])"

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')