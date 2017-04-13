function Get-StringInRedirectUrl([string] $url, [string] $regEx) {
    return $(Get-String (Get-RedirectUrl $url) $regEx)
}