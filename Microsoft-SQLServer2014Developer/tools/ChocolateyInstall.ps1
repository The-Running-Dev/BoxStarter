$packageChecksum            = '0972B32040B4D3B98D4604174248F7842A0A33F2AD38F35358F2BAA44691669BD29A0F8C715001DD5586A726CC78B00FF035BEC19FF390C2CFF8392B74FB1301EEC65BF523AC4A9DC01AEDF21BF53A3FAE25943AFEAA684874E605266A1F960F5DA312A2DA8FC32256DCCC2B07B4A815EFB1F128027272AB6AFB3260D0B84EAE'
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
