function Assert-TeamCityValidArguments {
    param(
        [Parameter(Position = 0, Mandatory)][hashtable] $arguments
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
        [Parameter(Position = 0, Mandatory)][hashtable] $arguments
    )

    $packageArgs = Get-Arguments $arguments

    Set-TeamCityInstallOptions $packageArgs

    if ($parameters.installDir) {
        $packageArgs.installDir = $parameters.installDir
    }

    if ($parameters.dataDir) {
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

function Install-TeamCityBuildAgent {
    param(
        [Parameter(Position = 0, Mandatory)][hashtable] $arguments
    )

    $buildAgentDir = Join-Path $arguments.installDir 'BuildAgent'

    if (Test-Path $buildAgentDir) {
        return
    }

    $buildAgentProperties = Join-Path $buildAgentDir 'Conf\buildAgent.properties'
    $serverUrl = "serverUrl=$arguments.serverUrl"
    (Get-Content $buildAgentProperties) -replace 'serverUrl=.*', $serverUrl | Set-Content $buildAgentProperties

    $buildAgentNewDir = Join-Path $arguments.installDir 'BuildAgent-1'
    Move-Item $buildAgentDir $buildAgentNewDir
    $buildAgentDir = $buildAgentNewDir

    Start-ChocolateyProcessAsAdmin "$buildAgentDir\bin\service.install.bat" | Out-Null
}

function Install-TeamCityDatabase {
    param(
        [Parameter(Position = 0, Mandatory)][hashtable] $arguments
    )

    if (-not (Assert-SQLServerDatabaseExists $arguments.databaseServer $arguments.databaseName)) {
        #New-SqlServerDatabase $arguments.databaseServer $arguments.databaseName
        #Add-SqlServerUserToRole $arguments.databaseServer $arguments.databaseName 'NT AUTHORITY\SYSTEM' 'db_owner'

        Restore-SQLServerBackupNew $arguments.databaseServer $arguments.databaseName $arguments.databaseBackup
    }

    # Build and set the JDBC connection string in the database.properties
    $connectionString = Get-JDBCSQLServerConnectionString `
        -Server $arguments.databaseServer `
        -Port $arguments.databaseServerPort `
        -Database $arguments.databaseName
    Set-Content "$($arguments.dataDir)\config\database.properties" $connectionString
}

function Initialize-TeamCityConfiguration {
    param(
        [Parameter(Position = 0, Mandatory)][hashtable] $arguments
    )

    if (Test-Path $arguments.dataDir) {
        return
    }

    $packageTeamCityDir = Join-Path $env:ChocolateyPackageFolder 'TeamCity'

    Copy-Item $packageTeamCityDir\** "$($arguments.installDir)\" -Recurse -Force

    $serverXml = Join-Path $arguments.installDir 'Conf\server.xml'
    $teamcityStartup = Join-Path $arguments.installDir 'Conf\teamcity-startup.properties'

    # Set the port number in server.xml
    Set-XmlValue $serverXml '//ns:Server/Service/Connector/@port' $arguments.port

    # Set the data directory path
    $dataDir = ($arguments.dataDir -replace '\\', '\\') -replace ':', '\:'
    Set-Content $teamcityStartup "teamcity.data.path=$dataDir"

    Remove-Item "$($arguments.installDir)\`$PLUGINSDIR" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "$($arguments.installDir)\`$TEMP" -Recurse -Force -ErrorAction SilentlyContinue
}

function Install-TeamCityServices {
    param(
        [Parameter(Position = 0, Mandatory)][hashtable] $arguments
    )

    $installArgs = @()
    if ($arguments.runAsSystem) {
        $installArgs += '/runAsSystem'
    }
    else {
        $installArgs += "/user=`"$($arguments.userName)`""
        $installArgs += "/password=`"$($arguments.password)`""

        if ($arguments.domain) {
            $installArgs += "/domain=`"$($arguments.domain)`""
        }
    }

    Start-ChocolateyProcessAsAdmin "$($arguments.installDir)\bin\teamcity-server.bat configure" | Out-Null
    Start-ChocolateyProcessAsAdmin "$($arguments.installDir)\bin\teamcity-server.bat service install $($installArgs -join ' ')" | Out-Null

    Start-Service $arguments.serviceName
}

function Set-TeamCityInstallOptions {
    param(
        [Parameter(Position = 0, Mandatory)][hashtable] $arguments
    )

    $packageParameters = $env:chocolateyPackageParameters

    if ($packageParameters) {
        $parameters = ConvertFrom-StringData -StringData $env:chocolateyPackageParameters.Replace(" ", "`n")

        $parameters.GetEnumerator() | ForEach-Object {
            $arguments[($_.Key)] = ($_.Value)
        }
    }
}

function Restore-SQLServerBackup {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $server,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $database,
        [Parameter(Position = 2, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $backup
    )

    $sqlServer = New-Object Microsoft.SqlServer.Management.Smo.Server $server

    $dbRestore = New-Object Microsoft.SqlServer.Management.Smo.Restore
    $dbRestore.Database = $database

    $dbRestoreFile = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile
    $dbRestoreFile.LogicalFileName = $database
    $dbRestoreFile.PhysicalFileName = "$($sqlServer.DefaultFile)\$($dbRestore.Database)_Data.mdf"
    $sqlServer.Information

    $dbRestoreLog = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile
    $dbRestoreLog.LogicalFileName = "$($database)_Log"
    $dbRestoreLog.PhysicalFileName = "$($sqlServer.DefaultLog)\$($dbRestore.Database)_Log.ldf"

    $dbRestore.Devices.AddDevice($backup, 'File')
    $dbRestore.ReplaceDatabase = $true
    $dbRestore.RelocateFiles.Add($dbRestoreFile)
    $dbRestore.RelocateFiles.Add($dbRestoreLog)

    try {
        $sqlServer.KillAllProcesses($database)
        $dbRestore.SqlRestore($sqlServer)

        Write-Host "Database $database restored successfully..."

        return $true
    }
    catch {
        Write-Host "Database $database restore failed..."

        return $false
    }
}