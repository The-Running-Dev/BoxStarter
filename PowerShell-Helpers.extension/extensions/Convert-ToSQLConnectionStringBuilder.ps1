function Convert-ToSqlConnectionStringBuilder {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory)][string] $connectionString
    )

    $server = Get-StringValueFromKey $connectionString 'Server|Data Source'
    $database = Get-StringValueFromKey $connectionString 'Database|Initial Catalog'
    $userId = Get-StringValueFromKey $connectionString 'User Id'
    $password = Get-StringValueFromKey $connectionString 'Password'

    return Get-SqlConnectionStringBuilder $server $database $userId $password
}