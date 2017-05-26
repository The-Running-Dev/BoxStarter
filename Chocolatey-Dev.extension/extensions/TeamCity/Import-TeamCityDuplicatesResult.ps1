function Import-TeamCityDuplicatesResult([string]$path) {
	Write-TeamCityServiceMessage 'importData' @{ type='DotNetDupFinder'; path=$path }
}