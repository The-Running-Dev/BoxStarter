function Get-Argument {
	param(
		[PSCustomObject] $arguments,
		[string] $key,
		[Object] $defaultValue = $null
	)

	if ($arguments.ContainsKey($key)) {
		if ($arguments[$key] -ne $null) {
			return $arguments[$key]
		}

		return $defaultValue
	}

	return $defaultValue
}