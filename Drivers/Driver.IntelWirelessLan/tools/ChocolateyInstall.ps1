$packageChecksum    = '3B740D4939EA6C9B863AA034E53272DBF4A6795F235D9ED1A29EB737A94C403BF707D8C8F056BAA10BB4F90319EFAB6C11F32338065685BD9461C6B5416820A1'
$arguments          = @{
    file            = 'WLAN(v18.40.4).zip'
    url             = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/WLAN/WLAN(v18.40.4).zip'
    checksum        = 'F2D5E50376DFC46FD5FEC062F996AEE12EEC5327CEC1A64D109B1625EFB9ECF9'
    executable      = 'WLAN(v18.40.4)\Win7Plus\Win64\Install\Setup.exe'
    silentArgs      = "-s -norestart -c ""default"""
}

Install-CustomPackage $arguments
