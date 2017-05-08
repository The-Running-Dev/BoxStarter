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
    file            = 'SQLEXPR_x64_ENU.exe'
    url             = 'https://download.microsoft.com/download/2/A/5/2A5260C3-4143-47D8-9823-E91BB0121F94/SQLEXPR_x64_ENU.exe'
    checksum        = 'cc35e94030a24093a62e333e900c2e3c8f1eb253a5d73230a9f5527f1046825b'
    silentArgs      = "/Q /x:`"$env:Temp\$installerBase`""
    executable      = '$env:Temp\$installerBase\Setup.exe'
    executableArgs  = '$env:Temp\Setup.exe'
    validExitCodes  = @(2147781575, 2147205120)
}

Install-Package $arguments

Get-ChildItem $env:Temp -Filter $installerBase | Remove-Item -Recurse -Force
