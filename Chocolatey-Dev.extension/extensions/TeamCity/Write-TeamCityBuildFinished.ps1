function Write-TeamCityBuildFinished([string]$message) {
	Write-TeamCityServiceMessage 'progressFinish' $message
}