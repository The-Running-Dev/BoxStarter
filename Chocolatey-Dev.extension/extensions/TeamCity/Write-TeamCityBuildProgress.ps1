function Write-TeamCityBuildProgress([string]$message) {
	Write-TeamCityServiceMessage 'progressMessage' $message
}