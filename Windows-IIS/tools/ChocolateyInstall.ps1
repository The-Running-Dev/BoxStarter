$packageChecksum    = '1C9C88AA6CE208766833D8BC212EA9FDE4726A10AFB28AEF0A9ACBE7D1478768A199435613D8317BC48470CF9B51FDB7C8620D0094B966F4DD19436DCBBA1BCB'
$defaultConfigFile  = Join-Path $env:ChocolateyPackageFolder 'IIS.config'
$parameters         = Get-Parameters $env:packageParameters
$configurationFile  = Get-ConfigurationFile $parameters['file'] $defaultConfigFile

if ([System.Environment]::OSVersion.Version.Major -eq 6){
    Enable-WindowsFeatures $configurationFile
}
else {
    # .NET and extensibility
    Enable-WindowsFeature NetFx3
    Enable-WindowsFeature NetFx4Extended-ASPNET45

    # Web server
    Enable-WindowsFeature IIS-WebServer
    Enable-WindowsFeature IIS-ManagementConsole

    # ASP.NET
    Enable-WindowsFeature IIS-ASPNET
    Enable-WindowsFeature IIS-ASPNET45
}
