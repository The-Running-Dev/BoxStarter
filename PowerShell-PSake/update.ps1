param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.begin.ps1')

function global:au_GetLatest {
    $url = 'https://github.com/psake/psake/archive/v$version.zip'
    $version = (Get-GitHubVersion 'psake/psake').Version

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $ExecutionContext.InvokeCommand.ExpandString($url); Version = $version }
}

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.end.ps1')