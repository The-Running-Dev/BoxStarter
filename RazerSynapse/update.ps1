param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadEndpointUrl = 'http://drivers.razersupport.com//index.php?_m=downloads&_a=downloadfile&downloaditemid=2116'
    $downloadUrl = 'http://razerdrivers.s3.amazonaws.com/drivers/Synapse2/win/Razer_Synapse_Installer_v$($version).exe'
    $versionRegEx = '.*v([0-9\.]+)\.exe'

    $versionDownloadUrl = ((Get-WebURL -Url $downloadEndpointUrl).ResponseUri).AbsoluteUri
    $version = ([regex]::match($versionDownloadUrl, $versionRegEx).Groups[1].Value)
    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')