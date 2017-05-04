$packageChecksum            = '8FDAB4218052FD6667833230E0B50553F27377FBD20CACCBBDEF01C6026AA926'
$defaultConfigurationFile   = Join-Path (Get-ParentDirectory $script) 'Configuration.ini'
$parameters                 = Get-Parameters $env:chocolateyPackageParameters
$configurationFile          = Get-ConfigurationFile $parameters['ConfigurationFile'] $defaultConfigurationFile
$silentArgs                 = "/IAcceptSQLServerLicenseTerms /ConfigurationFile=""$($configurationFile)"""

if (!$parameters.ContainsKey['sqlsysadminaccounts']) {
    $silentArgs = $silentArgs + " /SQLSYSADMINACCOUNTS=""$(whoami)"""
}

$arguments          = @{
    file            = 'Microsoft SQL Server 2016 Developer SP1.iso'
    executable      = 'Setup.exe'
    silentArgs      = $silentArgs
    validExitCodes  = @(2147781575, 2147205120)
}

if ($parameters.file) {
    $arguments.file = $parameters.file
}

Install-FromIso $arguments
