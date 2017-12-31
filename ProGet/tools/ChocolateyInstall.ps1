. (Join-Path $PSScriptRoot 'Helpers.ps1')

$packageArgs    = Get-ProGetInstallArguments
$arguments      = @{
    url         = 'https://s3.amazonaws.com/cdn.inedo.com/downloads/proget/ProGetSetup5.0.4.exe'
    checksum    = 'C1A2F11DFAE381546F1461C52DD206D6C92256B40A62B0BBABB612068B15008F'
    silentArgs  = $packageArgs.silentArgs
}

Install-Package $arguments

Set-ProGetWebSiteBindings $packageArgs
