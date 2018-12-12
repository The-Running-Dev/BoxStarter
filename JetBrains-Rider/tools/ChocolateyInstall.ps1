$arguments          = @{
    url             = 'https://download.jetbrains.com/rider/JetBrains.Rider-2018.2.3.exe'
    checksum        = 'B94C23F2A3E4937BBFD5971222BE37B3DC29B1A8F807E9416C8DB25D69381F70'
    silentArgs      = '/S'
}

Install-Package $arguments
