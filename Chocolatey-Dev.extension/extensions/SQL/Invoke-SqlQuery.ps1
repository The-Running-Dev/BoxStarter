function Invoke-SqlQuery {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][string] $server,
        [Parameter(Position = 1, Mandatory = $true, ValueFromPipelineByPropertyName = $true)][string] $database,
        [Parameter(Position = 2, Mandatory = $true, ValueFromPipelineByPropertyName = $true)][string] $sql,
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