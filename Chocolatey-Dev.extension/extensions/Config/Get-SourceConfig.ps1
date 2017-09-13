function Get-SourceConfig() {
    param (
        [Parameter(Mandatory = $true, Position = 0)][Hashtable] $config,
        [Parameter(Mandatory = $false, Position = 2)][String] $sourceType = 'local'
    )

    if ($sourceType -match 'remote') {
        return $config.remote
    }

    return $config.local
}