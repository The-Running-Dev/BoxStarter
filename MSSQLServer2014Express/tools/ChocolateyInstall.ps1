$installerfile    = 'LogFusionSetup-5.2.1.exe'
$url              = 'https://www.binaryfortress.com/Data/Download/?package=logfusion&log=117'
$checksum         = '5EBAA729F3763F618961FD406ED5BD1828FEE656E2D330B76B699084623BE902'
$installer        = Join-Path $env:ChocolateyPackageFolder $installerfile

$defaultConfigurationFile   = Join-Path (Get-ParentDirectory $script) 'Configuration.ini'
$packageName                = 'MSSQLServer2014Express'
$installer                  = Join-Path (Get-ParentDirectory $script) 'SQLEXPR.exe'
$parameters                 = Get-Parameters $env:chocolateyPackageParameters
$configurationFile          = Get-ConfigurationFile $parameters['ConfigurationFile'] $defaultConfigurationFile
$silentArgs                 = "/IAcceptSQLServerLicenseTerms /ConfigurationFile=""$($configurationFile)"""
$os                         = if (IsSystem32Bit) { "x86" } else { "x64" }
$installer                  = "SQLEXPR_$os_ENU.exe"

if (!$parameters.ContainsKey['sqlsysadminaccounts']) {
    $silentArgs = $silentArgs + " /SQLSYSADMINACCOUNTS=""$(whoami)"""
}

$arguments                  = @{
    packageName             = 'MSSQLServer2014ExpressInstaller'
    unzipLocation           = (Get-CurrentDirectory $script)
    url                     = "https://download.microsoft.com/download/2/A/5/2A5260C3-4143-47D8-9823-E91BB0121F94/SQLEXPR_x86_ENU.exe"
    url64                   = "https://download.microsoft.com/download/2/A/5/2A5260C3-4143-47D8-9823-E91BB0121F94/SQLEXPR_x64_ENU.exe"
    checksum                = '0eff1354916410437c829e98989e5910d9605b2df31977bc33ca492405a0a9ab'
    checksum64              = 'cc35e94030a24093a62e333e900c2e3c8f1eb253a5d73230a9f5527f1046825b'
    fileType                = 'exe'
    softwareName            = 'MSSQLServer2014Express*'
    silentArgs              = "/Q /x:`"$env:Temp\MSSQLServer2014Express\SQLEXPR`""
    validExitCodes          = @(
        0, # success
        3010, # success, restart required
        2147781575, # pending restart required
        2147205120  # pending restart required for setup update
    )
}

$installerPath = Get-Installer $parameters
$userInstallerPath = $parameters['installer']

if (!([System.IO.File]::Exists($installerPath))) {
    # Download and run the pre-installer
    Install-ChocolateyPackage @arguments

    # Set the path to the extracted setup
    $arguments['file'] = "$env:Temp\$packageName\SQLEXPR\Setup.exe"
}
elseif (([System.IO.File]::Exists($userInstallerPath))) {
    # Installer was specified and it exists

    # Run the pre-installer
    $arguments['file'] = $userInstallerPath
    Install-ChocolateyInstallPackage @arguments

    # Set the path to the extracted setup
    $arguments['file'] = "$env:Temp\$packageName\SQLEXPR\Setup.exe"
}

# Run the extracted setup
$arguments['packageName'] = $packageName
$arguments['silentArgs'] = $silentArgs
Install-LocalOrRemote $arguments

if (Test-Path "$env:Temp\$packageName") {
    Remove-Item -Recurse "$env:Temp\$packageName"
}