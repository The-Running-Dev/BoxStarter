function Get-RedirectUrl {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $url
    )

    $response = Get-WebURL -Url $url

    return $response.ResponseUri.AbsoluteUri
}