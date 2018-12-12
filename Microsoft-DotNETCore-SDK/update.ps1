param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://dotnet.microsoft.com/download'
    $downloadLinkRegEx = 'dotnet-sdk-([0-9\.]+)-windows-x64-installer'
    $thankYouPageUrl = 'https://www.microsoft.com/net/download/thank-you/dotnet-sdk-$version-windows-x64-installer'

    $releasePage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $version = [regex]::match($releasePage.Content, $downloadLinkRegEx).Groups[1].Value
    $thankYouPageUrl = $ExecutionContext.InvokeCommand.ExpandString($thankYouPageUrl)

    $downloadPage = Invoke-WebRequest -UseBasicParsing -Uri $thankYouPageUrl
    $url = $downloadPage.Links | Where-Object outerHTML -match '\.exe' | Select-Object -First 1 -Expand href

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')