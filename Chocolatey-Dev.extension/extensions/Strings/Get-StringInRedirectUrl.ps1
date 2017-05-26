function Get-StringInRedirectUrl {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $url,
        [Parameter(Position = 1, ValueFromPipeline = $true)][string] $regEx
    )

    return (Get-String (Get-RedirectUrl $url) $regEx)
}