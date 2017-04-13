param([switch] $force)

. (Join-Path $PSScriptRoot '..\Build\update.begin.ps1')

function global:au_GetLatest {
    return @{
        Url32 = 'http://launchy.net/downloads/win/LaunchySetup2.6B2.exe'
        Version = '2.6.2.1'
    }
}

. (Join-Path $PSScriptRoot '..\Build\update.end.ps1')