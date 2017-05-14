function Get-JdbcSqlServerConnectionString {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][string] $server,
        [Parameter(Position = 1, Mandatory = $true, ValueFromPipelineByPropertyName = $true)][string] $database,
        [Parameter(Position = 2, Mandatory = $false, ValueFromPipelineByPropertyName = $false)][int] $port = 1433,
        [Parameter(Position = 3, ValueFromPipelineByPropertyName = $false)][string] $user = '',
        [Parameter(Position = 4, ValueFromPipelineByPropertyName = $false)][secureString] $password
    )

    $credentials = "IntegratedSecurity\=true;"

    if ($user -and $password) {
        $passwordAsPlainText = Convert-SecureStringToString $password
        $credentials = "User=$user;Password=$passwordAsPlainText"
    }

    $connectionString = "connectionUrl=jdbc\:sqlserver\://$server\:$port;databaseName\=$database;$credentials"

    return $connectionString
}