$packageChecksum            = 'CC35E94030A24093A62E333E900C2E3C8F1EB253A5D73230A9F5527F1046825B'
$defaultConfigurationFile   = Join-Path $env:chocolateyPackageFolder 'Configuration.ini'
$parameters                 = Get-Parameters $env:chocolateyPackageParameters
$configurationFile          = Get-ConfigurationFile $parameters['ConfigurationFile'] $defaultConfigurationFile
$silentArgs                 = "/IAcceptSQLServerLicenseTerms /ConfigurationFile=""$($configurationFile)"""

if (!$parameters.ContainsKey['sqlsysadminaccounts']) {
    $silentArgs = $silentArgs + " /SQLSYSADMINACCOUNTS=""$(whoami)"""
}

$installerBase      = 'Microsoft SQL Server 2014 Express'
$arguments          = @{
    file            = 'Microsoft SQL Server 2014 Express.exe'
    silentArgs      = "/Q /x:`"$env:Temp\$installerBase`""
    executable      = "$env:Temp\$installerBase\Setup.exe"
    executableArgs  = $silentArgs
    validExitCodes  = @(2147781575, 2147205120)
}

Install-Package $arguments

Get-ChildItem $env:Temp -Filter $installerBase | Remove-Item -Recurse -Force
