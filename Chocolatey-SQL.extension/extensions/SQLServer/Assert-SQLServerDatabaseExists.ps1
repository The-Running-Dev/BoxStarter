function Assert-SqlServerDatabaseExists {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $server,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true)][string] $database,
        [Parameter(Position = 3, ValueFromPipelineByPropertyName = $false)][string] $user = '',
        [Parameter(Position = 4, ValueFromPipelineByPropertyName = $false)][secureString] $password
    )

    $exists = $false

    try {
        $conn = New-Object System.Data.SqlClient.SqlConnection
        $conn.ConnectionString = Get-SqlServerConnectionString $server $database $user $password
        $conn.Open()

        $exists = $true
    }
    catch {
    }

    return $exists
}