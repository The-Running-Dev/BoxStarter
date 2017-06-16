$updatedOn = '2017.06.08 12:25:16'
$arguments = @{
    file       = 'WLAN(v18.40.4).zip'
    url        = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/WLAN/WLAN(v18.40.4).zip'
    checksum   = 'F707D8C8F056BAA10BB4F90319EFAB6C11F32338065685BD9461C6B5416820A1'
    executable = 'WLAN(v18.40.4)\Win7Plus\Win64\Install\Setup.exe'
    silentArgs = "-s -norestart -c ""default"""
}

Install-FromZip $arguments
