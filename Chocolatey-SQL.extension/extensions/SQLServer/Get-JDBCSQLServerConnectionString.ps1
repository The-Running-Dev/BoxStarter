function Get-JDBCSQLServerConnectionString {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][string] $server,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][string] $database,
        [Parameter(Position = 2, ValueFromPipelineByPropertyName)][int] $port = 1433,
        [Parameter(Position = 3, ValueFromPipelineByPropertyName)][string] $user,
        [Parameter(Position = 4, ValueFromPipelineByPropertyName)][secureString] $password
    )

    $credentials = "IntegratedSecurity\=true;"

    if ($user -and $password) {
        $passwordAsPlainText = Convert-SecureStringToString $password
        $credentials = "User=$user;Password=$passwordAsPlainText"
    }

    $connectionString = "connectionUrl=jdbc\:sqlserver\://$server\:$port;databaseName\=$database;$credentials"

    return $connectionString
}