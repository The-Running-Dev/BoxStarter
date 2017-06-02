$updatedOn = '5E9CB101830A12B682E1618DFBBE5F1F7FFED50B86BEF9D67B57E19A9D8EADAF93D5F0AFED372F17602ECF87536C218942032A9A9679C77841A3F189827DCB931AE59BB779288D161563BC9E861C33A5B5D8C4CFA343C9E79C906008150292A4'
$defaultConfigurationFile = Join-Path $env:chocolateyPackageFolder 'Configuration.ini'
$parameters = Get-Parameters $env:chocolateyPackageParameters
$configurationFile = Get-ConfigurationFile $parameters['ConfigurationFile'] $defaultConfigurationFile
$silentArgs = "/IAcceptSQLServerLicenseTerms /ConfigurationFile=""$($configurationFile)"""

if (!$parameters.ContainsKey['sqlsysadminaccounts']) {
    $silentArgs = $silentArgs + " /SQLSYSADMINACCOUNTS=""$(whoami)"""
}

$installerBase = 'Microsoft SQL Server 2014 Express'
$arguments = @{
    file           = 'Microsoft SQL Server 2014 Express.exe'
    silentArgs     = "/Q /x:`"$env:Temp\$installerBase`""
    executable     = "$env:Temp\$installerBase\Setup.exe"
    executableArgs = $silentArgs
    validExitCodes = @(2147781575, 2147205120)
}

Install-Package $arguments

Get-ChildItem $env:Temp -Filter $installerBase | Remove-Item -Recurse -Force
