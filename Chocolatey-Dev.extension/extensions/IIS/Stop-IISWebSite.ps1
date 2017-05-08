function Stop-IISWebSite
{
	[CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $webSite
    )

    $pool = Get-Item "IIS:\$webSite" -ErrorAction SilentlyContinue

	if ($pool) {
		Write-Host "Stopping Web Site `"$webSite`""
		Stop-Website -Name $webSite
	}
}