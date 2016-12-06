$script                     = $MyInvocation.MyCommand.Definition
$defaultConfigurationFile   = Join-Path (GetParentDirectory $script) 'Configuration.ini'
$parameters                 = ParseParameters $env:chocolateyPackageParameters
$configurationFile          = GetConfigurationFile $parameters['ConfigurationFile'] $defaultConfigurationFile
$silentArgs                 = "/IAcceptSQLServerLicenseTerms /ConfigurationFile=""$($configurationFile)"""

if (!$parameters.ContainsKey['sqlsysadminaccounts']) {
    $silentArgs = $silentArgs + " /SQLSYSADMINACCOUNTS=""$(whoami)"""
}

$packageArgs                = @{
    packageName               = 'MSSQLServer2014Developer'
    unzipLocation             = (GetCurrentDirectory $script)
    fileType                  = 'exe'
    file                      = Join-Path (GetParentDirectory $script) 'Setup.exe'
    softwareName              = 'MSSQLServer2014Developer*'
    silentArgs                = $silentArgs
    validExitCodes            = @(
        0, # success
        3010, # success, restart required
        2147781575, # pending restart required
        2147205120  # pending restart required for setup update
    )
}

Install $packageArgs