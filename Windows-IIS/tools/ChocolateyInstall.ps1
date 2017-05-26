$packageChecksum    = '3D642AC84DE9AA97B14C06562C0E25D84DD0B5C34B1D74CFF0E3739C22FFF5EBADF999C1D4177371A5668A90C83AA4F5941CFEE03C05641F4794197B5DD830F0'
$defaultConfigFile  = Join-Path $env:ChocolateyPackageFolder 'IIS.config'
$parameters         = Get-Parameters $env:packageParameters
$configurationFile  = Get-ConfigurationFile $parameters['file'] $defaultConfigFile

if ([System.Environment]::OSVersion.Version.Major -eq 6){
    Install-Applications $configurationFile
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
