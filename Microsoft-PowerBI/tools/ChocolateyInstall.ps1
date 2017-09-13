$arguments          = @{
    url             = 'https://download.microsoft.com/download/9/B/A/9BAEFFEF-1A68-4102-8CDF-5D28BFFE6A61/PBIDesktop_x64.msi'
    checksum        = 'D77BA74AAECC173932D350475A1E22B612D5777E385191E954241A8A55D6D0F7'
    silentArgs      = "/quiet ACCEPT_EULA=1 /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-Package $arguments
