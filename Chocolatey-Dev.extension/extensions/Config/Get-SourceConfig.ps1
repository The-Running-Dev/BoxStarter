function Get-SourceConfig {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory)][ValidateNotNullOrEmpty()][Hashtable] $config,
        [Parameter(Position = 1)][String] $sourceType = 'local'
    )

    if ($sourceType -match 'remote') {
        return $config.remote
    }

    return $config.local
}