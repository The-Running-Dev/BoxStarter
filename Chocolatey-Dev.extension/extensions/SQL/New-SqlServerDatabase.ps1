function New-SqlServerDatabase {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $server,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true)][string] $database,
        [Parameter(Position = 3, ValueFromPipelineByPropertyName = $false)][string] $user = '',
        [Parameter(Position = 4, ValueFromPipelineByPropertyName = $false)][secureString] $password
    )
    $message = "`nCreating '$database' on '$server'"

    if ($PSCmdlet.ShouldProcess("$message")) {
        Write-Host $message

        $sqlServer = New-Object Microsoft.SqlServer.Management.Smo.Server $server
        $sqlServerDatabase = New-Object Microsoft.SqlServer.Management.Smo.Database $sqlServer, $database
        $sqlServerDatabase.Create()
    }
}