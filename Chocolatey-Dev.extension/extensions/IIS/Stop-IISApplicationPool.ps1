function Stop-IISApplicationPool
{
	[CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $appPool
    )

    $pool = Get-Item "IIS:\AppPools\$appPool" -ErrorAction SilentlyContinue

	if ($pool -and ((get-WebAppPoolState -name $appPool).Value -eq "Started")) {
		Write-Host "Stopping Application Pool `"$appPool`""
		Stop-WebAppPool -Name $appPool
	}
}