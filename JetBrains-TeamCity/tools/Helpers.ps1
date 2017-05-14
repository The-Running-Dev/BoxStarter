function Assert-ValidTeamCityArguments {
    param(
        [Parameter(Position = 0, Mandatory = $true)][hashtable] $arguments
    )

    if ((Get-Service $arguments.serviceName -ErrorAction SilentlyContinue)) {
        Write-Host 'TeamCity service is alredy installed...aborting.'

        return
    }

    if (-not (Assert-TcpPortIsOpen $arguments.servicePortNumber)) {
        return
    }
}

function Get-TeamCityInstallArguments {
    param(
        [Parameter(Position = 0, Mandatory = $true)][hashtable] $arguments
    )

    $packageArgs = Get-Arguments $arguments

    Set-InstallOptions $packageArgs

    if ([System.IO.Directory]::Exists($parameters.installDir)) {
        $packageArgs.installDir = $parameters.installDir
    }

    if ([System.IO.Directory]::Exists($parameters.dataDir)) {
        $packageArgs.dataDir = $parameters.dataDir
    }

    if ([System.IO.Directory]::Exists($parameters.javaDir)) {
        $packageArgs.javaDir = $parameters.javaDir
    }

    if ($packageArgs.userName -and $packageArgs.password) {
        $packageArgs.runAsSystem = $false
    }

    if (![System.IO.File]::Exists($packageArgs.file)) {
        $packageArgs.file = Get-ChocolateyWebFile @packageArgs
    }

    return $packageArgs
}

function Set-InstallOptions {
    param(
        [Parameter(Position = 0, Mandatory = $true)][hashtable] $arguments
    )

    $packageParameters = $env:chocolateyPackageParameters

    if ($packageParameters) {
        $parameters = ConvertFrom-StringData -StringData $env:chocolateyPackageParameters.Replace(" ", "`n")

        $parameters.GetEnumerator() | ForEach-Object {
            $arguments[($_.Key)] = ($_.Value)
        }
    }
}

function Initialize-TeamCityDataDirectory {
    param(
        [Parameter(Position = 0, Mandatory = $true)][hashtable] $arguments
    )

    $packageDir = $env:ChocolateyPackageFolder
    $confDir = Join-Path $packageArgs.installDir 'conf'

    Remove-Item "$($arguments.installDir)\`$PLUGINSDIR" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "$($arguments.installDir)\`$TEMP" -Recurse -Force -ErrorAction SilentlyContinue

    if (Test-Path $confDir) {
    }
    else {
        Get-ChocolateyUnzip -FileFullPath $packageArgs.configurationZip -Destination $packageArgs.installDir | Out-Null
    }

    if (Test-Path $($arguments.dataDir)) {
    }
    else {
        Get-ChocolateyUnzip -FileFullPath $packageArgs.dataZip -Destination $packageArgs.installDir | Out-Null
    }

    if (-not (Test-Path (Join-Path $confDir 'server.xml'))) {
        Copy-Item $arguments.serverConfig (Join-Path $confDir 'server.xml')
    }
    else {
        # Set the port number in server.xml
    }

    $dataDir = ($packageArgs.dataDir -replace '\\', '\\') -replace ':', '\:'
    Set-Content "$($packageArgs.installDir)\conf\teamcity-startup.properties" "teamcity.data.path=$dataDir"

    <#
    $configDir = "$($arguments.dataDir)\config"
    if (-not (Test-Path $configDir)) {
        New-Item -ItemType Directory $configDir | Out-Null
    }

    $jdbcDir = "$($arguments.dataDir)\lib\jdbc"
    if (-not (Test-Path $jdbcDir)) {
        New-Item -ItemType Directory $jdbcDir | Out-Null
    }

    $pluginsDir = "$($arguments.dataDir)\plugins"
    if (-not (Test-Path $pluginsDir)) {
        New-Item -ItemType Directory $pluginsDir | Out-Null
        Copy-Item "$packageDir\Plugins\**" "$pluginsDir\" | Out-Null
    }

    $mySqlConnector = "$($arguments.dataDir)\lib\jdbc\mysql-connector-java-5.1.42-bin.jar"
    if (-not (Test-Path $mySqlConnector)) {
        Copy-Item "$packageDir\Database\mysql-connector-java-5.1.42-bin.jar" $mySqlConnector | Out-Null
    }

    $sqlServerConnector = "$($arguments.dataDir)\lib\jdbc\sqljdbc42.jar"
    if (-not (Test-Path $sqlServerConnector)) {
        Copy-Item "$packageDir\Database\sqljdbc42.jar" $sqlServerConnector | Out-Null
    }
    #>

    $sqlServerIntegratedAuth = "$($arguments.javaDir)\bin\sqljdbc_auth.dll"
    if (-not (Test-Path $sqlServerIntegratedAuth)) {
        Copy-Item "$packageDir\Database\sqljdbc_auth_x86.dll" $sqlServerIntegratedAuth | Out-Null
    }
}

function Install-TeamCityDatabase {
    param(
        [Parameter(Position = 0, Mandatory = $true)][hashtable] $arguments
    )

    if (-not (Assert-SqlServerDatabaseExists $packageArgs.databaseServer $packageArgs.databaseName)) {
        #New-SqlServerDatabase $packageArgs.databaseServer $packageArgs.databaseName
        #Add-SqlServerUserToRole  $packageArgs.databaseServer $packageArgs.databaseName 'NT AUTHORITY\SYSTEM' 'db_owner'

        Restore-SqlServerBackup $packageArgs.databaseServer $packageArgs.databaseName $packageArgs$databaseBackup
    }

    # Build and set the JDBC connection string in the database.properties
    $connectionString = Get-JdbcSqlServerConnectionString `
        -Server $packageArgs.databaseServer `
        -Port $packageArgs.databaseServerPort `
        -Database $packageArgs.databaseName
    Set-Content "$($packageArgs.dataDir)\config\database.properties" $connectionString
}

function Install-TeamCityBuildAgent {
    param(
        [Parameter(Position = 0, Mandatory = $true)][hashtable] $arguments
    )

    $packageDir = $env:ChocolateyPackageFolder

    $buildAgentProperties = "$($arguments.installDir)\buildAgent\conf\buildAgent.properties"
    if (-not (Test-Path $buildAgentProperties)) {
        Copy-Item "$packageDir\BuildAgent\buildAgent.properties" $buildAgentProperties | Out-Null

        (Get-Content $buildAgentProperties) -replace 'serverUrl=.*', $arguments. | Set-Content $buildAgentProperties
    }

    Start-ChocolateyProcessAsAdmin "$($arguments.installDir)\buildAgent\bin\service.install.bat" | Out-Null
}

function Install-TeamCityServices {
    param(
        [Parameter(Position = 0, Mandatory = $true)][hashtable] $arguments
    )

    $installArgs = @()
    if ($arguments.runAsSystem) {
        $installArgs += '/runAsSystem'
    }
    else {
        $installArgs += "/user=`"$($arguments.userName)`""
        $installArgs += "/password=`"$($arguments.password)`""

        if ($packageArgs.domain) {
            $installArgs += "/domain=`"$($arguments.domain)`""
        }
    }

    Start-ChocolateyProcessAsAdmin "$($arguments.installDir)\bin\teamcity-server.bat configure" | Out-Null
    Start-ChocolateyProcessAsAdmin "$($arguments.installDir)\bin\teamcity-server.bat service install $($installArgs -join ' ')" | Out-Null

    Start-Service $arguments.serviceName
}