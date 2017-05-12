function Set-ChocolateyPackageOptions {
    param(
        [Parameter(Position = 0, Mandatory = $true)][hashtable] $options
    )

    $packageParameters = $env:chocolateyPackageParameters

    if ($packageParameters) {
        $parameters = ConvertFrom-StringData -StringData $env:chocolateyPackageParameters.Replace(" ", "`n")

        $parameters.GetEnumerator() | ForEach-Object {
            $options[($_.Key)] = ($_.Value)
        }
    }
}

function Get-TeamCityService() {
    param(
        [Parameter(Position = 0, Mandatory = $true)][string] $serviceName
    )

    $service = Get-Service $serviceName -ErrorAction SilentlyContinue

    if ($service) {
        return $true
    }

    return $false
}

function New-TeamCityDatabase {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $server,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true)][string] $database,
        [Parameter(Position = 3, ValueFromPipelineByPropertyName = $false)][string] $user = '',
        [Parameter(Position = 4, ValueFromPipelineByPropertyName = $false)][secureString] $password
    )

    [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | Out-Null
    [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SmoExtended") | Out-Null

    $sqlServer = New-Object Microsoft.SqlServer.Management.Smo.Server $server
    $sqlServerDatabase = New-Object Microsoft.SqlServer.Management.Smo.Database $sqlServer, $database
    $sqlServerDatabase.Create()

    Add-UserToRole $server 'TeamCity' 'NT AUTHORITY\SYSTEM' 'db_owner'

    Write-Host 'Database' $database 'created...done.'
}

Function Add-UserToRole {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $server,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true)][string] $database,
        [Parameter(Position = 3, ValueFromPipelineByPropertyName = $false)][string] $user,
        [Parameter(Position = 4, ValueFromPipelineByPropertyName = $false)][string] $role
    )

    $sqlServer = New-Object Microsoft.SqlServer.Management.Smo.Server $server
    $sqlServerDatabase = $sqlServer.Databases[$database]

    if (-not $sqlServerDatabase) {
        Write-Host "Database '$Database' does not exist on server '$server'...aborting."

        Write-Host "Available Database on '$server': "
        $sqlServer.Databases | Select-Object name

        break
    }

    # Check if role exists in the database
    $sqlServerRole = $sqlServerDatabase.Roles[$role]

    if (-not $sqlServerRole) {
        Write-Host "Role '$role' is not a valid role in the '$database' database...aborting."
        Write-Host "Available Roles in '$database':"

        $sqlServerDatabase.Roles | Select-Object name

        break
    }

    if (!($sqlServer.Logins.Contains($user))) {
        Write-Host "User '$user' does not exist on server '$server'...aborting."

        break
    }

    if (-not $sqlServerDatabase.Users.Contains($user)) {
        $login = New-Object Microsoft.SqlServer.Management.Smo.User $sqlServerDatabase, $user
        $login.Login = $user
        $login.Create()

        $sqlServerRole = $sqlServerDatabase.Roles[$role]
        $sqlServerRole.AddMember($user)

        Write-Host "User '$user' added to role '$role' in database '$database'...done."
    }
    else {
        $sqlServerRole = $sqlServerDatabase.Roles[$role]
        $sqlServerRole.AddMember($user)

        Write-Host "User '$user' added to role '$role' in database '$database'...done."
    }
}

function Invoke-SqlNonQuery {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $server,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true)][string] $database,
        [Parameter(Position = 2, ValueFromPipelineByPropertyName = $true)][string] $sql,
        [Parameter(Position = 3, ValueFromPipelineByPropertyName = $false)][string] $user = '',
        [Parameter(Position = 4, ValueFromPipelineByPropertyName = $false)][secureString] $password
    )

    $credentials = "Integrated Security=SSPI"

    if ($user -and $password) {
        $passwordAsPlainText = Convert-SecureStringToString $password
        $credentials = "User=$user;Password=$passwordAsPlainText"
    }

    $connectionString = "Data Source=$server;$credentials;Initial Catalog=$database"

    $connection = New-Object System.Data.SqlClient.SQLConnection($connectionString)
    $command = New-Object System.Data.SqlClient.SQLCommand($sql, $connection)
    $message = "`nServer: $server`nDatabase: $database`nSQL: `n$sql"

    if ($PSCmdlet.ShouldProcess("$message")) {
        $connection.Open()
        $command.ExecuteNonQuery()
        $connection.Close()
    }
}

function Uninstall-Service {
    param(
        [Parameter(Position = 0, Mandatory = $true)][string] $serviceName
    )

    if (Get-TeamCityService $serviceName) {
        Stop-Service $service
    }

    if ($service) {
        & sc.exe delete $serviceName
    }
}
