. (Join-Path $PSScriptRoot '..\Build\update.common.ps1')

function global:au_GetLatest {
    return @{
        Url32 =  'http://vpnarea.com/VPNAreaChameleon.exe';
        Version = '1.0.47.277'
    }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion