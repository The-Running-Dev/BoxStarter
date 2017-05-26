function Write-TeamCityBuildStatus([string]$status=$null, [string]$text='') {
	$messageAttributes = @{ text=$text }

	if (![string]::IsNullOrEmpty($status)) {
		$messageAttributes.status = $status
	}

	Write-TeamCityServiceMessage 'buildStatus' $messageAttributes
}