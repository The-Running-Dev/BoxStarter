function New-IISSite
{
	[CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $siteName,
        [Parameter(Position = 1, ValueFromPipeline = $true)][string] $physicalPath,
		[Parameter(Position = 2, ValueFromPipeline = $true)][string] $applicationPool
    )

	if(!(Test-Path IIS:\Sites\$siteName))
	{
        Write-Host "Creating Web Site `"$siteName`""
		New-Website -name $siteName -PhysicalPath $physicalPath -ApplicationPool $applicationPool -HostHeader $siteName
	}
    else {
        Write-Host "Web Site `"$siteName`" Already Exists. Updating Path to `"$physicalPath`""
    }
}