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