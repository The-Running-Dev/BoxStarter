function Set-TeamCityParameter([string]$name, [string]$value) {
    Write-TeamCityServiceMessage 'setParameter' @{ name = $name; value = $value }
}