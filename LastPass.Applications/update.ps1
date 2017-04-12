. (Join-Path $PSScriptRoot '..\Build\update.begin.ps1')

function global:au_GetLatest {
    $releasesUrl = 'https://lastpass.com/misc_download2.php'
    $downloadUrl = 'https://lastpass.com/download/cdn/lastappinstall_x64.exe'
    $versionRegEx = 'lastappinstall\.exe.*?Version ([0-9\.]+)'

    $html = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl -UserAgent $userAgent

    $version = [regex]::match($html, $versionRegEx).Groups[1].Value
    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    return @{ Url32 = $downloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion