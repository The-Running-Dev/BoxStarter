function Stop-IISWebSite
{
	[CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $webSite
    )

    $pool = Get-Item "IIS:\$webSite" -ErrorAction SilentlyContinue

	if ($pool) {
		Write-Host "Stopping Web Site `"$webSite`""
		Stop-Website -Name $webSite
	}
}