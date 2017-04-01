$defaultConfigFile  = Join-Path $env:ChocolateyPackageFolder 'IIS.config'
$parameters         = Get-Parameters $env:packageParameters
$parameters['file'] = Get-ConfigurationFile $parameters['file'] $defaultConfigFile

if ([System.Environment]::OSVersion.Version.Major -eq 6 -or $parameters['file'] -ne $defaultConfigFile){
    Install-Applications $parameters['file']
}
else {
    # .NET and extensibility
    Enable-WindowsFeature NetFx3
    Enable-WindowsFeature NetFx4Extended-ASPNET45

    # Web server
    Enable-WindowsFeature IIS-WebServer

    # ASP.NET
    Enable-WindowsFeature IIS-ASPNET
    Enable-WindowsFeature IIS-ASPNET45
}

# Install the Rewrite filter
choco install IIS.UrlRewrite -y