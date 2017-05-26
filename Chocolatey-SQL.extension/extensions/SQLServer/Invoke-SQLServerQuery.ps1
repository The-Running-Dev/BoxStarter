function Invoke-SQLServerQuery {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $sql,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName)][string] $server,
        [Parameter(Position = 2, ValueFromPipelineByPropertyName)][string] $database,
        [Parameter(Position = 3, ValueFromPipelineByPropertyName)][string] $user,
        [Parameter(Position = 4, ValueFromPipelineByPropertyName)][secureString] $password,
        [Parameter(Position = 5, ValueFromPipelineByPropertyName)][string] $connectionString
    )

    if (-not $connectionString) {
        $builder = Get-SQLConnectionStringBuilder $server $database $user $password
        $connectionString = $builder.ConnectionString
    }

    $connection = New-Object System.Data.SqlClient.SQLConnection($connectionString)
    $command = New-Object System.Data.SqlClient.SQLCommand($sql, $connection)
    $adapter = New-Object System.Data.Sqlclient.SqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet

    $message = "`nServer: $server`nDatabase: $database`nSQL: `n$sql"

    if ($PSCmdlet.ShouldProcess("$message")) {
        $connection.Open()
        $adapter.Fill($dataSet) | Out-Null
        $connection.Close()

        return $dataSet.Tables
    }
}