param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'http://www.filehorse.com/download-vmware-workstation/'
    $downloadUrl = 'https://download3.vmware.com/software/wkst/file/VMware-workstation-full-$($fileVersion).exe'
    $versionRegEx = '.*VMware Workstation ([0-9\.]+) Build ([0-9]+)'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $versionInfo = [regex]::match($releasePage.Content, $versionRegEx)
    $version = $versionInfo.Groups[1].Value
    $build = $versionInfo.Groups[2].Value

    $fileVersion = "$version-$build"
    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')