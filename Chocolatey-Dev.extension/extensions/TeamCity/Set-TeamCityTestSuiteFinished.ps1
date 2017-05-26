function Set-TeamCityTestSuiteFinished([string]$name) {
	Write-TeamCityServiceMessage 'testSuiteFinished' @{ name=$name }
}