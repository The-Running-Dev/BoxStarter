function New-IISApplication {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][string] $parentSite,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][string] $name,
        [Parameter(Position = 2, Mandatory, ValueFromPipelineByPropertyName)][string] $physicalPath,
        [Parameter(Position = 3, Mandatory, ValueFromPipelineByPropertyName)][string] $appPool,
        [Parameter(Position = 4, ValueFromPipelineByPropertyName)][string] $isSubApplication
    )

    if ($isSubApplication) {
        $exists = Test-Path "IIS:\\Sites\\$parentSite\\$name"
    }
    else {
        $exists = Get-WebApplication -site $parentSite -Name $name
    }

    if (-not $exists) {
        Write-Host "Creating Web Application '$name'..."
        New-WebApplication -Site $parentSite -Name $name -ApplicationPool $appPool -PhysicalPath $physicalPath
    }
    else {
        Write-Host "The application '$name' already exists...updating path."

        Set-ItemProperty IIS:\\Sites\\$parentSite\\$name -name physicalPath -value $physicalPath
        Write-Host "Physical path changed to '$physicalPath'"

        Set-ItemProperty IIS:\\Sites\\$parentSite\\$name -Name applicationPool -Value $appPool
        Write-Output "Application pool set to '$appPool'"
    }
}