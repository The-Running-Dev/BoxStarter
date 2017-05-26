. (Join-Path $PSScriptRoot 'Helpers.ps1')

$packageArgs    = Get-ProGetInstallArguments
$arguments      = @{
    url         = 'https://s3.amazonaws.com/cdn.inedo.com/downloads/proget/ProGetSetup4.7.12.exe'
    checksum    = 'DC227F14CC798C9D4C070ACDEA2B5E58519DBDB9D20A00DC355279D4A0DC4B15'
    silentArgs  = $packageArgs.silentArgs
}

Install-Package $arguments

Set-ProGetWebSiteBindings $packageArgs
