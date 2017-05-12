param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms'
    $versionRegEx = 'The build number for this release: ([0-9\.]+)'
    $downloadLinkRegEx = 'Download SQL Server Management Studio'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = ([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)
    $downloadEndpointUrl = $releasePage.Links | Where-Object outerHTML -match $downloadLinkRegEx | Select-Object -First 1 -Expand href
    $downloadUrl = Get-RedirectUrl $downloadEndpointUrl

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')