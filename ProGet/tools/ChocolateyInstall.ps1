. (Join-Path $PSScriptRoot 'Helpers.ps1')

$packageArgs    = Get-ProGetInstallArguments
$arguments      = @{
    url         = 'https://s3.amazonaws.com/cdn.inedo.com/downloads/proget/ProGetSetup5.0.3.exe'
    checksum    = '852D18BBBFA84BE463699C80435E7C882B5A0F2E2F506C51F2A9824C9BB874E7'
    silentArgs  = $packageArgs.silentArgs
}

Install-Package $arguments

Set-ProGetWebSiteBindings $packageArgs
