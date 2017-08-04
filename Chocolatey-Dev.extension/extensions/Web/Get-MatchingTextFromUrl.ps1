function Get-MatchingTextFromUrl {
    param (
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $releaseUrl,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName)][string] $versionRegEx,
        [Parameter(Position = 2, ValueFromPipelineByPropertyName)][string] $versionFormatString = '{0}',
        [Parameter(Position = 3, ValueFromPipelineByPropertyName)][string] $versionValues = '$matches[1]'
    )

    $releasePage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $releasePage.Content -match $versionRegEx | Out-Null

    $version = $versionFormatString -f (Invoke-Expression $versionValues)

    return $version
}