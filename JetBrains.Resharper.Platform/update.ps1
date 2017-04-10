. (Join-Path $PSScriptRoot '..\update.common.ps1')

function global:au_GetLatest {
    $releasesUrl = 'https://resharper-support.jetbrains.com/hc/en-us/articles/207242355-Where-can-I-download-an-old-previous-ReSharper-version-'
    $downloadUrl = 'https://download-cf.jetbrains.com/resharper/JetBrains.ReSharperUltimate.$($version).exe'
    $versionRegEx = 'ReSharper ([0-9\.]+) \(release date'

    $downloadPage = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl
    $version = $downloadPage.Content -match $versionRegEx

    if ($matches) {
        $version = $matches[1]
    }

    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    return @{ Url32 = $downloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion