param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadUrl = 'https://github.com/pester/Pester/archive/$version.zip'
    $version = (Get-GitHubVersion 'pester/Pester').Version

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl); Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')