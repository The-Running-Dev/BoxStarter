function Get-Argument {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline)][PSCustomObject] $arguments,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName)][string] $key,
        [Parameter(Position = 2, ValueFromPipelineByPropertyName)][Object] $defaultValue = $null
    )

    if ($arguments) {
        if ($arguments.ContainsKey($key)) {
            if ($arguments[$key] -ne $null) {
                return $arguments[$key]
            }

            return $defaultValue
        }
    }

    return $defaultValue
}