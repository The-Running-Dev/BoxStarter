$arguments          = @{
    url             = 'https://download.microsoft.com/download/9/B/A/9BAEFFEF-1A68-4102-8CDF-5D28BFFE6A61/PBIDesktop_x64.msi'
    checksum        = '403B8E87B15DC9B642C98CE5E51B2F6BF02AF2B635EE97E1190877AE08805122'
    silentArgs      = "/quiet ACCEPT_EULA=1 /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-Package $arguments
