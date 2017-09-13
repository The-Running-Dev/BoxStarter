. (Join-Path $PSScriptRoot 'Helpers.ps1')

$packageArgs    = Get-ProGetInstallArguments
$arguments      = @{
    url         = 'https://s3.amazonaws.com/cdn.inedo.com/downloads/proget/ProGetSetup4.8.2.exe'
    checksum    = 'C60D4474C61C8B8C6B6B755151830BCCCAD9B83DF3F5A5C9C8AEE2E948A7E4A0'
    silentArgs  = $packageArgs.silentArgs
}

Install-Package $arguments

Set-ProGetWebSiteBindings $packageArgs
