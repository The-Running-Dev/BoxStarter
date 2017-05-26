function Invoke-SqlNonQuery {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $server,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true)][string] $database,
        [Parameter(Position = 2, ValueFromPipelineByPropertyName = $true)][string] $sql,
        [Parameter(Position = 3, ValueFromPipelineByPropertyName = $false)][string] $user = '',
        [Parameter(Position = 4, ValueFromPipelineByPropertyName = $false)][secureString] $password
    )

    $connectionString = Get-SqlServerConnectionString $server $database $user $password
    $connection = New-Object System.Data.SqlClient.SQLConnection($connectionString)
    $command = New-Object System.Data.SqlClient.SQLCommand($sql, $connection)
    $message = "`nServer: $server`nDatabase: $database`nSQL: `n$sql"

    if ($PSCmdlet.ShouldProcess("$message")) {
        $connection.Open()
        $command.ExecuteNonQuery()
        $connection.Close()
    }
}