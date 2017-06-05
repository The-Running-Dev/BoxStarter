function Import-TeamCityJSLintReport([string]$path) {
    Write-TeamCityServiceMessage 'importData' @{ type = 'jslint'; path = $path }
}