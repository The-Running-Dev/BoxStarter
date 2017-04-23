$packageChecksum            = 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855B574BE2878E0EE4F4F3897F3EEAF5391668AAB9B513443C6C5AC581FE9C2AEE0EEC65BF523AC4A9DC01AEDF21BF53A3FAE25943AFEAA684874E605266A1F960F0F4AAF17E712042BA28DDBA61918C52C2877BB8102DB8E60C02BF289B6705A4A'
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
