function Start-IISApplicationPool
{
	[CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $appPool
    )

    $pool = Get-Item "IIS:\AppPools\$appPool" -ErrorAction SilentlyContinue

	if ($pool -and ((get-WebAppPoolState -name $appPool).Value -eq "Stopped")) {
		Write-Host "Starting Application Pool `"$appPool`""
		Start-WebAppPool -Name $appPool
	}
}