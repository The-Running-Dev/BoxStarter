$packageChecksum            = 'DC21B4AFD36F4D7A106810030C347514EF3085BDF33A31908B3B4EA8A6211B14'
$installerBase              = 'Microsoft SQL Server 2016 Developer SP1'
$defaultConfigurationFile   = Join-Path $env:chocolateyPackageFolder 'Configuration.ini'
$parameters                 = Get-Parameters $env:chocolateyPackageParameters
$configurationFile          = Get-ConfigurationFile $parameters['ConfigurationFile'] $defaultConfigurationFile
$silentArgs                 = "/IAcceptSQLServerLicenseTerms /ConfigurationFile=""$($configurationFile)"""

if (-not $parameters.ContainsKey('sqlsysadminaccounts')) {
    $silentArgs = $silentArgs + " /SQLSYSADMINACCOUNTS=""$(whoami)"""
}

# The file is defined explictely so the update script can find it and embed it
$arguments          = @{
    file            = 'Microsoft SQL Server 2016 Developer SP1.7z'
    destination     = $env:Temp
    executable      = "$installerBase\Setup.exe"
    silentArgs      = $silentArgs
    validExitCodes  = @(2147781575, 2147205120)
}

# If the /file argument was specified, use the ISO to install
if ([System.IO.File]::Exists($parameters.file)) {
    $arguments.file = $parameters.file

    Install-FromIso $arguments
}
else {
    Install-FromZip $arguments

    Get-ChildItem $env:Temp -Filter $installerBase | Remove-Item -Recurse -Force
}
