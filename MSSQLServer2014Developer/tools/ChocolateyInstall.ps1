$script                     = $MyInvocation.MyCommand.Definition
$defaultConfigurationFile   = Join-Path (GetParentDirectory $script) 'Configuration.ini'
$packageName                = 'MSSQLServer2014Developer'
$installer                  = Join-Path (GetParentDirectory $script) 'Setup.exe'

$packageParameters          = ParseParameters $env:chocolateyPackageParameters
$configurationFile          = GetConfigurationFile $packageParameters['ConfigurationFile'] $defaultConfigurationFile
$silentArgs                 = "/IAcceptSQLServerLicenseTerms /ConfigurationFile=""$($configurationFile)"""

if (!$packageParameters.ContainsKey['sqlsysadminaccounts']) {
    $silentArgs = $silentArgs + " /SQLSYSADMINACCOUNTS=""$(whoami)"""
}

$packageArgs                = @{
    packageName               = $packageName
    unzipLocation             = (GetCurrentDirectory $script)
    fileType                  = 'exe'
    file                      = $installer
    softwareName              = 'MSSQLServer2014Developer*'
    silentArgs                = $silentArgs
    validExitCodes            = @(
        0, # success
        3010, # success, restart required
        2147781575, # pending restart required
        2147205120  # pending restart required for setup update
    )
}

InstallFromLocalOrRemote $packageArgs