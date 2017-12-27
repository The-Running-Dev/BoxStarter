param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $url = 'https://github.com/dahlbyk/posh-git/archive/v$version.zip'
    $version = (Get-GitHubVersion 'dahlbyk/posh-git').Version

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $ExecutionContext.InvokeCommand.ExpandString($url); Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')