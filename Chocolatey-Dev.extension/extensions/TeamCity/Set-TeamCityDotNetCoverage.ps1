# See http://confluence.jetbrains.net/display/TCD5/Manually+Configuring+Reporting+Coverage
function Set-TeamCityDotNetCoverage([string]$key, [string]$value) {
    Write-TeamCityServiceMessage 'dotNetCoverage' @{ $key = $value }
}