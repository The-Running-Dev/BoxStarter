function Set-TeamCityBlockClosed([string]$name) {
	Write-TeamCityServiceMessage 'blockClosed' @{ name=$name }
}