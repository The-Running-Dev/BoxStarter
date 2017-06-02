function Install-WebSite {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $name,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $physicalPath,
        [Parameter(Position = 2, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $webAppPath,
        [Parameter(Position = 3)][string] $appPool,
        [Parameter(Position = 4)][Alias('bindings')][string[]] $binding = @('http/*:80:'),
        [Parameter(Position = 4)][switch] $cleanPath = $false,
        [Parameter(Position = 5)][string[]] $excludeFromCleaning = @(),
        [Parameter(Position = 6)][PSCustomObject] $config = @{},
        [Parameter(Position = 7)][string] $environmentName
    )

    Stop-IISApplicationPool $appPool
    Stop-IISWebSite $name

    Install-IISAppPool -Name $appPool -ServiceAccount NetworkService

    Install-IISWebsite `
        -Name $name `
        -PhysicalPath $physicalPath `
        -AppPoolName $appPool `
        -Binding $binding

    if ((Test-Path $physicalPath) -and $cleanPath) {
        Get-ChildItem $physicalPath -Exclude $excludeFromCleaning -Recurse | Remove-Item -Recurse -Force
    }

    # Copy the web application
    Copy-Item "$webAppPath\**" "$physicalPath\" -Force -Recurse

    # Transform Web.config files
    Get-ChildItem $physicalPath -Filter 'Web.config' -Recurse | ForEach-Object {
        $currentFile = $_.FullName
        $currentDir = Split-Path -Parent $_.FullName
        $releaseConfig = Join-Path $currentDir 'Web.Release.config'
        $envConfig = Join-Path $currentDir "Web.$environmentName.config"

        if (Test-Path $releaseConfig) {
            Convert-XmlFile -Path $currentFile -XdtPath $releaseConfig -Destination "$currentFile.transformed" -Force | Out-Null
            Move-Item "$currentFile.transformed" $currentFile -Force | Out-Null
        }

        if ($environmentName -and (Test-Path $envConfig)) {
            Convert-XmlFile -Path $currentFile -XdtPath $envConfig -Destination  "$currentFile.transformed" -Force | Out-Null
            Move-Item "$currentFile.transformed" $currentFile -Force | Out-Null
        }
    }

    # Remove any left over transforms
    Remove-Item -Include 'Web.*.config' $physicalPath -Recurse

    # Update any connection strings
    Get-ChildItem $physicalPath -Filter 'Web.config' -Recurse | ForEach-Object {
        Set-ConnectionStrings $_.FullName $config
    }

    Start-WebAppPool -Name $appPool
    Start-WebSite -Name $name

    if ($url) {
        Test-Url $url

        try {
            Set-OctopusVariable -name "AppUrl" -value $url
        } catch {}
    }
}