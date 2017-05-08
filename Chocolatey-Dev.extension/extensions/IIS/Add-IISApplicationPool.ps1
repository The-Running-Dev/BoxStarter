function Add-IISApplicationPool
{
	[CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $appPool
    )

    $pool = Get-Item "IIS:\AppPools\$appPool" -ErrorAction SilentlyContinue

	if (!$pool) {
		Write-Host "Application Pool `"$appPool`" Does not Exist, Creating..."
		New-Item "IIS:\AppPools\$appPool" -confirm:$false

        $pool = Get-Item "IIS:\AppPools\$appPool"
	} else {
		Write-Host "Application Pool `"$appPool`" Already Exists."
	}
}