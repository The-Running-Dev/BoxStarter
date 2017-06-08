. (Join-Path $PSScriptRoot 'Helpers.ps1')

$packageArgs    = Get-ProGetInstallArguments
$arguments      = @{
    url         = 'https://s3.amazonaws.com/cdn.inedo.com/downloads/proget/ProGetSetup4.7.13.exe'
    checksum    = 'A02FF0FC527A328D51BBD5D9659DE13B61C753794FF846FB28E401DC407D9015'
    silentArgs  = $packageArgs.silentArgs
}

Install-Package $arguments

Set-ProGetWebSiteBindings $packageArgs
