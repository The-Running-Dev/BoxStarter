function Set-TeamCityTestSuiteStarted([string]$name) {
	Write-TeamCityServiceMessage 'testSuiteStarted' @{ name=$name }
}