function Import-TeamCityDotNetCoverageResult([string]$tool, [string]$path) {
    Write-TeamCityServiceMessage 'importData' @{ type = 'dotNetCoverage'; tool = $tool; path = $path }
}