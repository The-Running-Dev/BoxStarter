$arguments          = @{
    url             = 'https://download.microsoft.com/download/9/B/A/9BAEFFEF-1A68-4102-8CDF-5D28BFFE6A61/PBIDesktop_x64.msi'
    checksum        = '09BDB5B86E7FCAA4A317F37B1FB879BDAD75CDD4DA568CCC3731E8B8308D0FD5'
    silentArgs      = "/quiet ACCEPT_EULA=1 /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-Package $arguments
