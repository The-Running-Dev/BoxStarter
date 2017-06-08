$updatedOn = '2017.06.08 12:25:16'
$arguments = @{
    file       = 'WLAN(v18.40.4).zip'
    url        = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/WLAN/WLAN(v18.40.4).zip'
    checksum   = 'F2D5E50376DFC46FD5FEC062F996AEE12EEC5327CEC1A64D109B1625EFB9ECF9'
    executable = 'WLAN(v18.40.4)\Win7Plus\Win64\Install\Setup.exe'
    silentArgs = "-s -norestart -c ""default"""
}

Install-CustomPackage $arguments
