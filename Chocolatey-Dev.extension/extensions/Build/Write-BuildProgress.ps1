# Wrapper for reporting progress on the command line
# or to TeamCity via TeamCity.psm1/TeamCityReportBuildProgress
function Write-BuildProgress
{
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $message
    )

    # If the build is running inside TeamCity
    if ($env:TEAMCITY_VERSION) {
        Write-TeamCityBuildProgress $message
    }
    else {
        Write-Output "$($psake.context.Peek().currentTaskName) - $message"
    }
}