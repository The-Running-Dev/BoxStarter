param([switch] $force)

. (Join-Path $PSScriptRoot '..\Build\update.begin.ps1')

function global:au_GetLatest {
    return @{
        Url32 = 'http://downloads.sourceforge.net/project/kdiff3/kdiff3/0.9.98/KDiff3-64bit-Setup_0.9.98-2.exe';
        Version = '0.9.98'
    }
}

. (Join-Path $PSScriptRoot '..\Build\update.end.ps1')