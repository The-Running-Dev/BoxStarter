$packageChecksum    = '3D642AC84DE9AA97B14C06562C0E25D84DD0B5C34B1D74CFF0E3739C22FFF5EB31F9CF60B32CB188851E574C94459BF687C44B1A839C70850EF57A506D81BD86'
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
