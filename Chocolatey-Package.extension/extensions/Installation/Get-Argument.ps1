function Get-Argument([Hashtable] $arguments, [string] $key, [string] $defaultValue = $null) {
	if ($arguments.ContainsKey($key)) {
		$value = @{$true = $arguments[$key]; $false = $defaultValue}[$arguments[$key] -ne '']
		return $value
	}

	return $defaultValue
}