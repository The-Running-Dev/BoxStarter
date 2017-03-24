$installerfile    = 'LogFusionSetup-5.2.1.exe'
$url              = 'https://www.binaryfortress.com/Data/Download/?package=logfusion&log=117'
$checksum         = '5EBAA729F3763F618961FD406ED5BD1828FEE656E2D330B76B699084623BE902'
$script           = $MyInvocation.MyCommand.Definition
$installer        = Join-Path $env:ChocolateyPackageFolder  $installerfile
$defaultConfigurationFile   = Join-Path (Get-ParentDirectory $script) 'Configuration.ini'
$parameters                 = Get-Parameters $env:chocolateyPackageParameters
$configurationFile          = Get-ConfigurationFile $parameters['ConfigurationFile'] $defaultConfigurationFile
$silentArgs                 = "/IAcceptSQLServerLicenseTerms /ConfigurationFile=""$($configurationFile)"""

if (!$parameters.ContainsKey['sqlsysadminaccounts']) {
    $silentArgs = $silentArgs + " /SQLSYSADMINACCOUNTS=""$(whoami)"""
}

$arguments                  = @{
    packageName             = 'MSSQLServer2014Developer'
    softwareName            = 'Microsoft SQL Server*'
    unzipLocation           = $env:ChocolateyPackageFolder
    file                    = Join-Path (Get-ParentDirectory $script) 'Setup.exe'
    fileType                = 'exe'
    silentArgs              = $silentArgs
    validExitCodes          = @(
        0, # success
        3010, # success, restart required
        2147781575, # pending restart required
        2147205120  # pending restart required for setup update
    )
}

Install-LocalOrRemote $arguments