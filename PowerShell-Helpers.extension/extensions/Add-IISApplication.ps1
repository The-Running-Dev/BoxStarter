function Add-IISApplication
{
	[CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $parentSite,
        [Parameter(ValueFromPipeline = $true)] [string] $name,
		[Parameter(ValueFromPipeline = $true)] [string] $physicalPath,
		[Parameter(ValueFromPipeline = $true)] [string] $appPool,
		[Parameter(ValueFromPipeline = $true)] [string] $isSubApplication
    )

    if ($isSubApplication) {
        $exists = Test-Path IIS:\\Sites\\$parentSite\\$name
    }
    else {
        $exists = Get-WebApplication -site $parentSite -Name $name
    }

    if (!$exists) {
        Write-Host "Creating Web Application '$name'"
        New-WebApplication -Site $parentSite -Name $name -ApplicationPool $appPool -PhysicalPath $physicalPath
        Write-Host "Web Application Created"
    } else {
        Write-Host "The Web Application '$name' Already Exists. Updating Physical Path..."

        Set-ItemProperty IIS:\\Sites\\$parentSite\\$name -name physicalPath -value $physicalPath
        Write-Host "Physical Path Changed To: $physicalPath"

        Set-ItemProperty IIS:\\Sites\\$parentSite\\$name -Name applicationPool -Value $appPool
        Write-Output "ApplicationPool Changed To: $appPool"
    }
}