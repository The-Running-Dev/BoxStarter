function Get-SqlServerConnectionString {
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $server,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true)][string] $database,
        [Parameter(Position = 3, ValueFromPipelineByPropertyName = $false)][string] $user = '',
        [Parameter(Position = 4, ValueFromPipelineByPropertyName = $false)][secureString] $password
    )

    $credentials = "Integrated Security=SSPI"

    if ($user -and $password) {
        $passwordAsPlainText = Convert-SecureStringToString $password
        $credentials = "User=$user;Password=$passwordAsPlainText"
    }

    $connectionString = "Server=$server;Database=$database;$credentials;"

    return $connectionString
}