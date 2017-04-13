function Get-RedirectUrl([string] $url) {
    return ((Get-WebURL -Url $url).ResponseUri).AbsoluteUri
}