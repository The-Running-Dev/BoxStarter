function Import-TeamCityInspectionCodeResult([string]$path) {
	Write-TeamCityServiceMessage 'importData' @{ type='ReSharperInspectCode'; path=$path }
}