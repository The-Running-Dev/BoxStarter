function Get-RedirectUrl {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $url
    )

    $response = Get-WebURL -Url $url

    return $response.ResponseUri.AbsoluteUri
}