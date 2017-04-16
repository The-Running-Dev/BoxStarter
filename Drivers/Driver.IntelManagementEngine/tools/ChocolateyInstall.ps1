$packageChecksum    = 'BB3DBA9A9EA945A94DFC9BB6F53F3B4C5632E7F407E200C9A3D4C922879824E206F32B8994158FD3674DAAD67E93B612ED4162426D660F9A1EDAF1D93224E380'
$arguments          = @{
    file            = 'ME(v11.0.4.1186_MEI).zip'
    url             = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/Others/ME(v11.0.4.1186_MEI).zip'
    checksum        = '06F32B8994158FD3674DAAD67E93B612ED4162426D660F9A1EDAF1D93224E380'
    executable      = 'ME(v11.0.4.1186_MEI)\MEISetup.exe'
    silentArgs      = '-s -overwrite -drvonly'
}

Install-CustomPackage $arguments
