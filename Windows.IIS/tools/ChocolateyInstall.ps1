$script             = $MyInvocation.MyCommand.Definition
$defaultConfigFile  = Join-Path (Get-ParentDirectory $script) 'IIS.config'
$parameters         = Parse-Parameters $evn:packageParameters
$parameters['file'] = Get-ConfigurationFile $parameters['file'] $defaultConfigFile

if ([System.Environment]::OSVersion.Version.Major -eq 6 -or $parameters['file'] -ne $defaultConfigFile){
    Install-ChocoApplications $parameters['file']
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

# Install the Re-Write filter
choco install IIS.UrlRewrite -y