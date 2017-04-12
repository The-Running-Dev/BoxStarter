. (Join-Path $PSScriptRoot '..\Build\update.common.ps1')

function global:au_GetLatest {
    return @{
        Url32 = 'http://download.microsoft.com/download/C/9/E/C9E8180D-4E51-40A6-A9BF-776990D8BCA9/rewrite_amd64.msi';
        Version = '2.0.20160209'
    }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion