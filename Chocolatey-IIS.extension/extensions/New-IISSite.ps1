function New-IISSite {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $name,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $physicalPath,
        [Parameter(Position = 2, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $appPool,
        [Parameter(Position = 3, ValueFromPipelineByPropertyName)][string] $hostHeader = $name
    )

    if (!(Test-Path "IIS:\Sites\$name")) {
        Write-Host "Creating web site '$name'..."
        New-Website -name $name -PhysicalPath $physicalPath -ApplicationPool $appPool -HostHeader $hostHeader
    }
    else {
        Write-Host "Web Site '$name' already exists. Updating path to '$physicalPath'..."
    }
}