function Set-TeamCityTestStarted([string]$name) {
    Write-TeamCityServiceMessage 'testStarted' @{ name = $name }
}