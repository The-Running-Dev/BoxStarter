. (Join-Path $PSScriptRoot 'Helpers.ps1')

$arguments = @{
    url                = 'https://download-cf.jetbrains.com/teamcity/TeamCity-2017.1.2.exe'
    checksum           = '5D990E25C2C1CD17578CBA8F9C169AF2D786FE9C42BCF9713345E7A055CA34BF'
    installDir         = 'C:\TeamCity'
    dataDir            = 'C:\TeamCity\Data'
    javaDir            = 'C:\TeamCity\jre'
    runAsSystem        = $true
    serviceName        = 'TeamCity'
    port               = 8090
    userName           = ''
    domain             = ''
    password           = ''
    databaseServer     = 'localhost'
    databaseServerPort = 1433
    databaseName       = 'TeamCity'
    databaseBackup     = Join-Path $env:ChocolateyPackageFolder 'Database\TeamCity.bak'
}

Assert-TeamCityValidArguments $arguments

$packageArgs = Get-TeamCityInstallArguments $arguments

# Unzip the TeamCity installer
Get-ChocolateyUnzip -FileFullPath $packageArgs.file -Destination $packageArgs.installDir | Out-Null

# Setup the configuration and the data directory
Initialize-TeamCityConfiguration $packageArgs

# Install the SQL server database
Install-TeamCityDatabase $packageArgs

<#
# Install the TeamCity service
Install-TeamCityServices $packageArgs

# Install a TeamCity build agent
Install-TeamCityBuildAgent $packageArgs

#Export-CLIXml -Path (Join-Path $PSScriptRoot 'InstallOptions.xml') -InputObject $packageArgs
#Remove-Item $packageArgs.file -Recurse -Force
#>
