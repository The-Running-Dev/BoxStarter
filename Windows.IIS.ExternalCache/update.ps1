. (Join-Path $PSScriptRoot '..\Build\update.common.ps1')

function global:au_GetLatest {
    return @{
        Url32 = 'http://download.microsoft.com/download/C/A/5/CA5FAD87-1E93-454A-BB74-98310A9C523C/ExternalDiskCache_amd64.msi';
        Version = '1.1.20151123'
    }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion