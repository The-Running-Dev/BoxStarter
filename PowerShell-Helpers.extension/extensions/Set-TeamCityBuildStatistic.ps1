function Set-TeamCityBuildStatistic([string]$key, [string]$value) {
    Write-TeamCityServiceMessage 'buildStatisticValue' @{ key = $key; value = $value }
}