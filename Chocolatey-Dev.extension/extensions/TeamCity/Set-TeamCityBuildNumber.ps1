function Set-TeamCityBuildNumber([string]$buildNumber) {
	Write-TeamCityServiceMessage 'buildNumber' $buildNumber
}