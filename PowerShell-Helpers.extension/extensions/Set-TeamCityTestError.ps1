function Set-TeamCityTestError([string]$name, [string]$output) {
    Write-TeamCityServiceMessage 'testStdErr' @{ name = $name; out = $output }
}