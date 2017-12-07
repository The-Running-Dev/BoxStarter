function Get-SQLConnectionStringBuilder {
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][string] $server,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][string] $database,
        [Parameter(Position = 2, ValueFromPipelineByPropertyName)][string] $user,
        [Parameter(Position = 3, ValueFromPipelineByPropertyName)][secureString] $password
    )

    $builder = New-Object System.Data.SqlClient.SqlConnectionStringBuilder
    $builder['Data Source'] = $server
    $builder['Initial Catalog'] = $database
    $builder['Integrated Security'] = $true

    if ($user -and $password) {
        $builder['Integrated Security'] = $false
        $builder['User Id'] = $user
        $builder['Passwsord'] = Convert-SecureStringToString $password
    }

    return $builder
}