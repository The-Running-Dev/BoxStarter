function Start-IISWebSite()
{
	[CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $webSite
    )

    $pool = Get-Item "IIS:\$webSite" -ErrorAction SilentlyContinue

	if ($pool) {
		Write-Host "Starting Web Site `"$webSite`""
		Start-Website -Name $webSite
	}
}