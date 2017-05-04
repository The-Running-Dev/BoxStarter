param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://resharper-support.jetbrains.com/hc/en-us/articles/207242355-Where-can-I-download-an-old-previous-ReSharper-version-'
    $downloadUrl = 'https://download-cf.jetbrains.com/resharper/JetBrains.ReSharperUltimate.$($version).exe'
    $versionRegEx = 'ReSharper ([0-9\.]+) \(release date'

    $downloadPage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $version = [regex]::match($downloadPage.Content, $versionRegEx).Groups[1].Value

    if ($force) {
        $global:au_Version = $version
    }

    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')