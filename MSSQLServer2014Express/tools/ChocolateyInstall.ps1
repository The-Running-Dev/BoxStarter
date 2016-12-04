$script                     = $MyInvocation.MyCommand.Definition
$defaultConfigurationFile   = Join-Path (GetParentDirectory $script) 'Configuration.ini'
$packageName                = 'MSSQLServer2014Express'
$installer                  = Join-Path (GetParentDirectory $script) 'SQLEXPR.exe'

$packageParameters          = ParseParameters $env:chocolateyPackageParameters
$configurationFile          = GetConfigurationFile $packageParameters['ConfigurationFile'] $defaultConfigurationFile
$silentArgs                 = "/IAcceptSQLServerLicenseTerms /ConfigurationFile=""$($configurationFile)"""
$os                         = if ($IsSystem32Bit) { "x86" } else { "x64" }
$installer                  = "SQLEXPR_$os_ENU.exe"

if (!$packageParameters.ContainsKey['sqlsysadminaccounts']) {
    $silentArgs = $silentArgs + " /SQLSYSADMINACCOUNTS=""$(whoami)"""
}

$packageArgs = @{
    packageName             = 'MSSQLServer2014ExpressInstaller'
    unzipLocation           = (GetCurrentDirectory $script)
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

$setupPath = DetermineSetupPath $packageParameters
$installerPath = $packageParameters['installer']

if (!([System.IO.File]::Exists($setupPath))) {
    # Download and run the pre-installer
    Install-ChocolateyPackage @packageArgs

    # Set the path to the extracted setup 
    $packageArgs['file'] = "$env:Temp\MSSQLServer2014Express\SQLEXPR\Setup.exe"
}
elseif (([System.IO.File]::Exists($installerPath))) {
    # Installer was specified and it exists

    # Run the pre-installer
    $packageArgs['file'] = $installerPath
    Install-ChocolateyInstallPackage @packageArgs

    # Set the path to the extracted setup
    $packageArgs['file'] = "$env:Temp\MSSQLServer2014Express\SQLEXPR\Setup.exe"
}

# Run the extracted setup
$packageArgs['packageName'] = $packageName
$packageArgs['silentArgs'] = $silentArgs
InstallFromLocalOrRemote $packageArgs

if (Test-Path "$env:Temp\MSSQLServer2014Express") {
    Remove-Item -Recurse "$env:Temp\MSSQLServer2014Express"
}