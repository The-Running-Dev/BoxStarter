param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadUrl = 'https://github.com/dahlbyk/posh-git/archive/v$version.zip'
    $version = (Get-GitHubVersion 'dahlbyk/posh-git').Version

    if ($force) {
        $global:au_Version = $release.Version
    }

    return @{ Url32 = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl); Version = $version }
}

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.end.ps1')