param([switch] $force)

$packageDir = $PSScriptRoot
$global:au_packageInstallerDir = Join-Path $PSScriptRoot '.\extensions' -Resolve

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadEndPointUrl = 'https://search.maven.org/remote_content?g=com.madgag&a=bfg&v=LATEST'
    $versionRegEx = 'bfg-([0-9\.]+)\.jar'

    $url = ((Get-WebURL -Url $downloadEndPointUrl).ResponseUri).AbsoluteUri
    $version = ([regex]::match($url, $versionRegEx).Groups[1].Value)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')