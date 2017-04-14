function Invoke-GitAdd
{
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $file
    )

    GitConfig

    git add $file
}