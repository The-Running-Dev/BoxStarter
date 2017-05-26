function Get-StringValueFromKey {
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $sourceString,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $matchRegEx,
        [Parameter(Position = 2, ValueFromPipelineByPropertyName)][string] $delimiter = ';',
        [Parameter(Position = 3, ValueFromPipelineByPropertyName)][string] $keyValueDelimiter = '='
    )

    return $sourceString -split $delimiter | `
        Where-Object { $_ -match $matchRegEx } | ForEach-Object { $_ -Split $keyValueDelimiter } | `
        Select-Object -First 1 -Skip 1
}