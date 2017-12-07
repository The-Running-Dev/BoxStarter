function Write-BuildProgress {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $message
    )

    # If the build is running inside TeamCity
    if ($env:TEAMCITY_VERSION) {
        Write-TeamCityBuildProgress $message
    }
    else {
        Write-Output "$($psake.context.Peek().currentTaskName) - $message"
    }
}