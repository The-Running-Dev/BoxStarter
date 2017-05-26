function Set-TeamCityBuildProblem([string]$description, [string]$identity=$null) {
	$messageAttributes = @{ description=$description }

	if (![string]::IsNullOrEmpty($identity)) {
		$messageAttributes.identity=$identity
	}

	Write-TeamCityServiceMessage 'buildProblem' $messageAttributes
}