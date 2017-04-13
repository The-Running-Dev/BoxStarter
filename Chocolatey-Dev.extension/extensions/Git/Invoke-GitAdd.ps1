function Invoke-GitAdd
{
    [Alias("gita")]
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $file
    )

    GitConfig

    git add $file
}