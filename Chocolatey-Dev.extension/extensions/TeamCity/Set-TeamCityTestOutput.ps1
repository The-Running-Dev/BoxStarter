function Set-TeamCityTestOutput([string]$name, [string]$output) {
	Write-TeamCityServiceMessage 'testStdOut' @{ name=$name; out=$output }
}