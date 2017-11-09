. (Join-Path $PSScriptRoot 'Helpers.ps1')

$packageArgs    = Get-ProGetInstallArguments
$arguments      = @{
    url         = 'https://s3.amazonaws.com/cdn.inedo.com/downloads/proget/ProGetSetup4.8.7.exe'
    checksum    = '4965A5A92F97DF04239226BD4698FEB61B68DA6065D9B73456F35E174AE7EAA9'
    silentArgs  = $packageArgs.silentArgs
}

Install-Package $arguments

Set-ProGetWebSiteBindings $packageArgs
