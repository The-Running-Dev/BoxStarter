$arguments          = @{
    url             = 'https://download.ccleaner.com/rcsetup153.exe'
    checksum        = '75155568D64E958D8003F9FBB36839FC9A53BFAB3B51A8A1106A78E5BE98B2E9'
    silentArgs      = '/S'
}

Install-Package $arguments
