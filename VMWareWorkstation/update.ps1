. (Join-Path $PSScriptRoot '..\Build\update.common.ps1')

function global:au_GetLatest {
    $releasesUrl = 'http://www.filehorse.com/download-vmware-workstation/'
    $downloadUrl = 'https://download3.vmware.com/software/wkst/file/VMware-workstation-full-$($fileVersion).exe'
    $versionRegEx = '.*VMware Workstation ([0-9\.]+) Build ([0-9]+)'

    $html = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl
    $versionInfo = [regex]::match($html.Content, $versionRegEx)
    $version = $versionInfo.Groups[1].Value
    $build = $versionInfo.Groups[2].Value

    $fileVersion = "$version-$build"
    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    return @{ Url32 = $downloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion