# Parse input argument string into a hashtable
# Format: /param1=1234 /param2=1234
function ParseParameters ($s)
{
    $parameters = @{ }

    if (!$s)
    {
        return $parameters
    }

    $kvps = $s.Split(@(" "), [System.StringSplitOptions]::RemoveEmptyEntries)

    foreach ($kvp in $kvps)
    {
        $delimiterIndex = $kvp.IndexOf('=')
        if (($delimiterIndex -le 0) -or ($delimiterIndex -ge ($kvp.Length - 1))) { continue }

        $key = $kvp.Substring(1, $delimiterIndex - 1).Trim().ToLower()

        if ($key -eq '') { continue }

        $value = $kvp.Substring($delimiterIndex + 1).Trim()

        $parameters.Add($key, $value)
    }

    return $parameters
}

# Gets configuraiton file. Returns its path
function GetConfigurationFile($parameters, $defaultConfigurationFile)
{
    $configurationFile = $parameters['ConfigurationFile']

    if (!$configurationFile)
    {
        return $defaultConfigurationFile
    }

    if (($configurationFile.Replace("""", "") -as [System.URI]).AbsoluteURI -ne $null)
    {
        $localConfigurationFile = (Join-Path $env:temp 'Configuration.ini')

        if (Test-Path $localConfigurationFile)
        {
            Remove-Item $localConfigurationFile
        }

        Get-ChocolateyWebFile 'ConfigurationFile' $localConfigurationFile $configurationFile.Replace("""", "") | Out-Null
    }
    elseif (Test-Path $configurationFile)
    {
        $localConfigurationFile = $configurationFile;
    }
    else
    {
        throw 'Invalid Configuration File.'
    }

    return $localConfigurationFile
}

function GenerateInstallArguments($parameters, $configurationFile)
{
    $s = "/IAcceptSQLServerLicenseTerms /ConfigurationFile=""$($configurationFile)"""

    foreach ($key in $parameters.Keys)
    {
        if ($key -eq 'configurationfile') { continue };
        if ($key -eq 'setuppath') { continue };

        $value = $parameters[$key]

        $s = $s + " /$key=$value"
    }

    # If the user didn't specify users for the admin accounts,
    # add the current user
    if ($parameters['sqlsysadminaccounts'] -eq $null) {
        $s = $s + " /SQLSYSADMINACCOUNTS=""$(whoami)"""
    }

    return $s
}

function Install {
param(
    [string] $packageName
)
    $installerType = 'exe'
    $validExitCodes = @(
        0, # success
        3010, # success, restart required
        2147781575, # pending restart required
        2147205120  # pending restart required for setup update
    )

    $defaultConfigurationFile = Join-Path $PSScriptRoot 'Configuration.ini' -Resolve

    $packageParameters = ParseParameters $env:chocolateyPackageParameters
    $configurationFile = GetConfigurationFile $packageParameters $defaultConfigurationFile
    $silentArgs = GenerateInstallArguments $packageParameters $configurationFile
    $setupPath = $packageParameters['setuppath']

    if ($setupPath -ne $null -and (Test-Path $setupPath)) {
        Write-Host "Installing with Arguments:
$silentArgs"

        Write-Host "Installing SQL Server 2014 Developer..."
        Install-ChocolateyInstallPackage $packageName $installerType $silentArgs $setupPath -validExitCodes @(0, 3010)
    }
    else {
        throw "Setup Not Found at $setupPath"
    }
}

function Uninstall {
param(
  [string] $packageName,
  [string] $applicationName,
  [string] $uninstallerName
)
    <#
    Write-Debug "Running 'Uninstall-VS' for $packageName with url:`'$url`'";

    $installerType = 'exe'
    $silentArgs = '/Uninstall /force /Passive /NoRestart'

    $app = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "$applicationName*"} | Sort-Object { $_.Name } | Select-Object -First 1
    if ($app -ne $null)
    {
        $uninstaller = Get-Childitem "$env:ProgramData\Package Cache\" -Recurse -Filter $uninstallerName | ? { $_.VersionInfo.ProductVersion.StartsWith($app.Version)}
        if ($uninstaller -ne $null)
        {
            Uninstall-ChocolateyPackage $packageName $installerType $silentArgs $uninstaller.FullName
        }
    }
    #>
}

Export-ModuleMember *