function Invoke-GitConfig
{
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $email,
        [Parameter(Position = 1, ValueFromPipeline = $true)][string] $name
    )

    git config user.email $email
    git config user.name $name
}