function Set-TeamCityTestIgnored([string]$name, [string]$message = '') {
    Write-TeamCityServiceMessage 'testIgnored' @{ name = $name; message = $message }
}