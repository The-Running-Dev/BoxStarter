Import-Module (Join-Path -Resolve $PSScriptRoot 'TeamCity.psm1')

# Wrapper for reporting progress on the command line
# or to TeamCity via TeamCity.psm1/TeamCityReportBuildProgress
function Write-Progress
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

function Get-NextVersion
{
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [object] $version
    )

    $buildDate = $([DateTime]::Now.ToString("yyy.MM.dd"))
    $buildTime = $([DateTime]::Now.ToString("HH.mm.ss"))

    # If the date is the same as the previous date,
    # incriment the build number
    if ($version.Date -eq $buildDate) {
        $version.Build = ($version.Build -as [int]) + 1
    }
    else {
        $version.Build = 1
    }

    # Always set the date and time
    $version.Date = $buildDate
    $version.Time = $buildTime
    $version.Id = $version.Date + "." + (('', '0')[$version.Build -as [int] -lt 100], '00')[$version.Build -as [int] -lt 10] + $version.Build
}

Export-ModuleMember -Function *