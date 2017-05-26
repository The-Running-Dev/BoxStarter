function Assert-IsValidSqlServerConnectionString {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $connectionString
    )

    $isVald = $false

    try {
        $builder = Convert-ToSqlConnectionStringBuilder $connectionString
        $builder['Initial Catalog'] = 'master'

        $connection = New-Object System.Data.SqlClient.SqlConnection
        $connection.ConnectionString = $builder.ConnectionString
        $connection.Open()

        $isValid = $true
    }
    catch { }

    return $isValid
}