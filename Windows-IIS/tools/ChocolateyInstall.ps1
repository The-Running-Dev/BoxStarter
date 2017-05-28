$packageChecksum    = '2B70A0BC1D7B8AF28143471A71955A06A826BDBC46687187326DE6EA9A98B96C'
$defaultConfigFile  = Join-Path $env:ChocolateyPackageFolder 'IIS.config'
$parameters         = Get-Parameters $env:packageParameters
$configurationFile  = Get-ConfigurationFile $parameters['file'] $defaultConfigFile

if ([System.Environment]::OSVersion.Version.Major -gt 6){
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
else {
    Enable-WindowsFeatures $configurationFile
}
