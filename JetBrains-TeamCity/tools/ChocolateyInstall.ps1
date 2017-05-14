. (Join-Path $PSScriptRoot 'Helpers.ps1')

$arguments = @{
    url                 = 'https://download-cf.jetbrains.com/teamcity/TeamCity-2017.1.1.exe'
    checksum            = '8A469B0B1D912A15AEF79BCF55CD6D2155D48F795D9AE3C42F402D5AC08FCE5C'
    installDir          = 'C:\TeamCity'
    dataDir             = 'C:\TeamCity\Data'
    javaDir             = 'C:\TeamCity\jre'
    runAsSystem         = $true
    serviceName         = 'TeamCity'
    servicePortNumber   = 8090
    userName            = ''
    domain              = ''
    password            = ''
    serverConfig        = Join-Path $env:ChocolateyPackageFolder 'server.xml'
    databaseServer      = 'localhost'
    databaseServerPort  = 1433
    databaseName        = 'TeamCity'
    configurationZip    = Join-Path $env:ChocolateyPackageFolder 'Conf.7z'
    dataZip             = Join-Path $env:ChocolateyPackageFolder 'Data.7z'
    databaseBackup      = Join-Path $env:ChocolateyPackageFolder 'TeamCity.bak'
}

Assert-ValidTeamCityArguments $arguments

$packageArgs = Get-TeamCityInstallArguments $arguments

net stop TeamCity
sc.exe delete TeamCity
rms $packageArgs.installDir

# Unzip the TeamCity installer
Get-ChocolateyUnzip -FileFullPath $packageArgs.file -Destination $packageArgs.installDir | Out-Null

# Initialize and setup the Data directory
Initialize-TeamCityDataDirectory $packageArgs

# Install the SQL server database
Install-TeamCityDatabase $packageArgs

# Instlal the TeamCity services
Install-TeamCityServices $packageArgs

#Export-CLIXml -Path (Join-Path $PSScriptRoot 'InstallOptions.xml') -InputObject $packageArgs
#Remove-Item $packageArgs.file -Recurse -Force