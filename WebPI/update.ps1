. (Join-Path $PSScriptRoot '..\Build\update.common.ps1')

function global:au_GetLatest {
    return @{
        Url32 = 'https://go.microsoft.com/fwlink/?LinkId=255386';
        Version = '5.0'
    }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion