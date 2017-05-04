param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://lastpass.com/misc_download2.php'
    $downloadUrl = 'https://lastpass.com/download/cdn/lastappinstall_x64.exe'
    $versionRegEx = 'lastappinstall\.exe.*?Version ([0-9\.]+)'

    $releasePage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl -UserAgent $userAgent
    $version = [regex]::match($releasePage, $versionRegEx).Groups[1].Value
    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')