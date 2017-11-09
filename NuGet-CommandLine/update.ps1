param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://www.nuget.org/packages/NuGet.CommandLine/'
    $url = 'https://dist.nuget.org/win-x86-commandline/latest/nuget.exe'
    $versionRegEx = 'NuGet.CommandLine ([0-9\.]+)'

    $downloadPage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $version = [regex]::match($downloadPage, $versionRegEx).Groups[1].Value

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')