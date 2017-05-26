Function Add-SqlServerUserToRole {
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