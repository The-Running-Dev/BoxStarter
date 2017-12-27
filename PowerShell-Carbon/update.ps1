param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $url = 'https://github.com/pshdo/Carbon/archive/$version.zip'
    $releaseUrl = 'https://github.com/pshdo/Carbon/releases'
    $versionRegEx = '.*/releases/tag/(\d+\.\d+\.\d+)'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = [version]([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $ExecutionContext.InvokeCommand.ExpandString($url); Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')