$script                     = $MyInvocation.MyCommand.Definition
$defaultConfigurationFile   = Join-Path (Get-ParentDirectory $script) 'Configuration.ini'
$parameters                 = Get-Parameters $env:chocolateyPackageParameters
$configurationFile          = Get-ConfigurationFile $parameters['ConfigurationFile'] $defaultConfigurationFile
$silentArgs                 = "/IAcceptSQLServerLicenseTerms /ConfigurationFile=""$($configurationFile)"""

if (!$parameters.ContainsKey['sqlsysadminaccounts']) {
    $silentArgs = $silentArgs + " /SQLSYSADMINACCOUNTS=""$(whoami)"""
}

$packageArgs                = @{
    packageName               = 'MSSQLServer2014Developer'
    unzipLocation             = (Get-CurrentDirectory $script)
    fileType                  = 'exe'
    file                      = Join-Path (Get-ParentDirectory $script) 'Setup.exe'
    softwareName              = 'MSSQLServer2014Developer*'
    silentArgs                = $silentArgs
    validExitCodes            = @(
        0, # success
        3010, # success, restart required
        2147781575, # pending restart required
        2147205120  # pending restart required for setup update
    )
}

Install-LocalOrRemote $packageArgs