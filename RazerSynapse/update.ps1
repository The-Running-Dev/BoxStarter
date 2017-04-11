. (Join-Path $PSScriptRoot '..\Build\update.common.ps1')

function global:au_GetLatest {
    $downloadEndpointUrl = 'http://drivers.razersupport.com//index.php?_m=downloads&_a=downloadfile&downloaditemid=2116'
    $downloadUrl = 'http://dl.razerzone.com/drivers/Synapse2/win/Razer_Synapse_Framework_V$($version).exe'
    $versionRegEx = 'Razer_Synapse_Framework_V([0-9\.]+).exe'

    $versionDownloadUrl = ((Get-WebURL -Url $downloadEndpointUrl).ResponseUri).AbsoluteUri
    $version = ([regex]::match($versionDownloadUrl, $versionRegEx).Groups[1].Value)
    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    return @{ Url32 = $downloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion