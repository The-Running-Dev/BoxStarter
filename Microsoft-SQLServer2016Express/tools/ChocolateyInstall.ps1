$packageChecksum            = '2A5B64AE64A8285C024870EC4643617AC5146894DD59DD560E75CEA787BF9333'
$defaultConfigurationFile   = Join-Path $env:chocolateyPackageFolder 'Configuration.ini'
$parameters                 = Get-Parameters $env:chocolateyPackageParameters
$configurationFile          = Get-ConfigurationFile $parameters['ConfigurationFile'] $defaultConfigurationFile
$silentArgs                 = "/IAcceptSQLServerLicenseTerms /ConfigurationFile=""$($configurationFile)"""

if (!$parameters.ContainsKey['sqlsysadminaccounts']) {
    $silentArgs = $silentArgs + " /SQLSYSADMINACCOUNTS=""$(whoami)"""
}

$installerBase      = 'Microsoft SQL Server 2016 Express'
$arguments          = @{
    file            = 'Microsoft SQL Server 2016 Express.exe'
    silentArgs      = "/Q /x:`"$env:Temp\$installerBase`""
    executable      = "$env:Temp\$installerBase\Setup.exe"
    executableArgs  = $silentArgs
    validExitCodes  = @(2147781575, 2147205120)
}

Install-Package $arguments

Get-ChildItem $env:Temp -Filter $installerBase | Remove-Item -Recurse -Force
