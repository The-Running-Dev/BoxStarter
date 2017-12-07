function Import-TeamCityNUnitReport([string]$path) {
    Write-TeamCityServiceMessage 'importData' @{ type = 'nunit'; path = $path }
}