function Invoke-GitAdd
{
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $file
    )

    GitConfig

    git add $file
}