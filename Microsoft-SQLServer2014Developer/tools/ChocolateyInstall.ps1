$packageChecksum            = '965163D07F7CA5F1C44B52FE224B2060B10504ADB31755ABA0751D85FFFB1915'
$defaultConfigurationFile   = Join-Path (Get-ParentDirectory $script) 'Configuration.ini'
$parameters                 = Get-Parameters $env:chocolateyPackageParameters
$configurationFile          = Get-ConfigurationFile $parameters['ConfigurationFile'] $defaultConfigurationFile
$silentArgs                 = "/IAcceptSQLServerLicenseTerms /ConfigurationFile=""$($configurationFile)"""

if (!$parameters.ContainsKey['sqlsysadminaccounts']) {
    $silentArgs = $silentArgs + " /SQLSYSADMINACCOUNTS=""$(whoami)"""
}

$arguments          = @{
    file            = 'Microsoft SQL Server 2014 Developer SP2.iso'
    executable      = 'Setup.exe'
    silentArgs      = $silentArgs
    validExitCodes  = @(2147781575, 2147205120)
}

if ($parameters.file) {
    $arguments.file = $parameters.file
}

Install-CustomPackage $arguments
