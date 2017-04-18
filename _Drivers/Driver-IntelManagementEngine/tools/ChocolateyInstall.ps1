$packageChecksum    = '623EEADD273F06714AA89AE75F06E2A4778A3BE86399D304DEEA60275EB13F8806F32B8994158FD3674DAAD67E93B612ED4162426D660F9A1EDAF1D93224E380'
$arguments          = @{
    file            = 'ME(v11.0.4.1186_MEI).zip'
    url             = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/Others/ME(v11.0.4.1186_MEI).zip'
    checksum        = '06F32B8994158FD3674DAAD67E93B612ED4162426D660F9A1EDAF1D93224E380'
    executable      = 'ME(v11.0.4.1186_MEI)\MEISetup.exe'
    silentArgs      = '-s -overwrite -drvonly'
}

Install-CustomPackage $arguments
