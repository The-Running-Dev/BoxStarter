$packageChecksum    = '81B3FDEAED30CC621765627A60733C579AAB630339C7E684B97A1CAE42B3C157F2D5E50376DFC46FD5FEC062F996AEE12EEC5327CEC1A64D109B1625EFB9ECF9'
$arguments          = @{
    file            = 'Realtek_Audio(v7874).zip'
    url             = 'http://asrock.pc.cdn.bitgravity.com/Drivers/All/Audio/Realtek_Audio(v7874).zip'
    checksum        = 'F2D5E50376DFC46FD5FEC062F996AEE12EEC5327CEC1A64D109B1625EFB9ECF9'
    executable      = 'Realtek_Audio(v7874)\Setup.exe'
    silentArgs      = '/s /sms'
}

Install-CustomPackage $arguments
