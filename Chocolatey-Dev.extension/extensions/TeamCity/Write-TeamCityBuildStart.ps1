function Write-TeamCityBuildStart([string]$message) {
	Write-TeamCityServiceMessage 'progressStart' $message
}