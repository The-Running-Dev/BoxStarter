param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://go.skype.com/skype.download'

    $url = Get-RedirectUrl -url $releaseUrl
    $version = $url -Split '\-|\.exe$' | Select-Object -Last 1 -Skip 1

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')