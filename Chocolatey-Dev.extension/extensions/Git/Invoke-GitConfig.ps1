function Invoke-GitConfig
{
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $email,
        [Parameter(ValueFromPipeline = $true)] [string] $name
    )

    git config user.email $email
    git config user.name $name
}