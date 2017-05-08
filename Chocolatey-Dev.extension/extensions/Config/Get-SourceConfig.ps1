function Get-SourceConfig() {
    param (
        [Parameter(Position = 0, Mandatory = $true)][Hashtable] $config,
        [Parameter(Position = 1, Mandatory = $false)][String] $sourceType = 'local'
    )

    if ($sourceType -match 'remote') {
        return $config.remote
    }

    return $config.local
}