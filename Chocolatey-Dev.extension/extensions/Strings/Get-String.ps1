function Get-String {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $value,
        [Parameter(Position = 1, ValueFromPipeline = $true)][string] $regex
    )

    return $value -replace $regEx, '$1'
}