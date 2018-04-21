$arguments          = @{
    url             = 'https://download.microsoft.com/download/9/B/A/9BAEFFEF-1A68-4102-8CDF-5D28BFFE6A61/PBIDesktop_x64.msi'
    checksum        = '90CF3EF685316F85E6F253DFD7B20B58ACBB00B276279B987E17DE0B0B5023FB'
    silentArgs      = "/quiet ACCEPT_EULA=1 /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-Package $arguments
