function Add-IISSite
{
	[CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $siteName,
        [Parameter(ValueFromPipeline = $true)] [string] $physicalPath,
		[Parameter(ValueFromPipeline = $true)] [string] $applicationPool
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