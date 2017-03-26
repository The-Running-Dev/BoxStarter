Import-Module WebAdministration -Force

function Add-IISApplicationPool
{
	[CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $appPool
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

function Start-IISApplicationPool
{
	[CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $appPool
    )

    $pool = Get-Item "IIS:\AppPools\$appPool" -ErrorAction SilentlyContinue

	if ($pool -and ((get-WebAppPoolState -name $appPool).Value -eq "Stopped")) {
		Write-Host "Starting Application Pool `"$appPool`""
		Start-WebAppPool -Name $appPool
	}
}

function Stop-IISApplicationPool
{
	[CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $appPool
    )

    $pool = Get-Item "IIS:\AppPools\$appPool" -ErrorAction SilentlyContinue

	if ($pool -and ((get-WebAppPoolState -name $appPool).Value -eq "Started")) {
		Write-Host "Stopping Application Pool `"$appPool`""
		Stop-WebAppPool -Name $appPool
	}
}

function Start-IISWebSite()
{
	[CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $webSite
    )

    $pool = Get-Item "IIS:\$webSite" -ErrorAction SilentlyContinue

	if ($pool) {
		Write-Host "Starting Web Site `"$webSite`""
		Start-Website -Name $webSite
	}
}

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

Export-ModuleMember -Function *