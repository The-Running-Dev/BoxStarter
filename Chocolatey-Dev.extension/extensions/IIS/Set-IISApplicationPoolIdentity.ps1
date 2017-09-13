function Set-IISApplicationPoolIdentity
{
	[CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $appPool,
        [Parameter(ValueFromPipeline = $true)] [string] $appPoolIdentityType
    )

	Write-Host "Setting Application Pool Identity: $appPoolIdentityType"

	Set-ItemProperty "IIS:\AppPools\$appPool" -name processModel -value @{identitytype="$appPoolIdentityType"}
}