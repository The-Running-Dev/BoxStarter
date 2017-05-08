function Set-IISApplicationPoolIdentity
{
	[CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $appPool,
        [Parameter(Position = 1, ValueFromPipeline = $true)][string] $appPoolIdentityType
    )

	Write-Host "Setting Application Pool Identity: $appPoolIdentityType"

	Set-ItemProperty "IIS:\AppPools\$appPool" -name processModel -value @{identitytype="$appPoolIdentityType"}
}