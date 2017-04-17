$arguments          = @{
    file            = 'PBIDesktop_x64.msi'
    url             = 'https://download.microsoft.com/download/9/B/A/9BAEFFEF-1A68-4102-8CDF-5D28BFFE6A61/PBIDesktop_x64.msi'
    checksum        = 'DF156C1ECCF1C934DB55F9E49E93CA87C0BA7C67585319C0F47FC18CA66EA42A'
    silentArgs      = "/quiet ACCEPT_EULA=1 /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-CustomPackage $arguments
