function Set-TeamCityTestFailed([string]$name, [string]$message, [string]$details='', [string]$type='', [string]$expected='', [string]$actual='') {
	$messageAttributes = @{ name=$name; message=$message; details=$details }

	if (![string]::IsNullOrEmpty($type)) {
		$messageAttributes.type = $type
	}

	if (![string]::IsNullOrEmpty($expected)) {
		$messageAttributes.expected=$expected
	}
	if (![string]::IsNullOrEmpty($actual)) {
		$messageAttributes.actual=$actual
	}

	Write-TeamCityServiceMessage 'testFailed' $messageAttributes
}