$updatedOn = '69CC2BE95E0CB364A30AA0E456D196EC312427E69618FA90F538963B1978301EF2D5E50376DFC46FD5FEC062F996AEE12EEC5327CEC1A64D109B1625EFB9ECF9'
$arguments = @{
    file       = 'Realtek_Audio(v7874).zip'
    url        = 'http://asrock.pc.cdn.bitgravity.com/Drivers/All/Audio/Realtek_Audio(v7874).zip'
    checksum   = 'F2D5E50376DFC46FD5FEC062F996AEE12EEC5327CEC1A64D109B1625EFB9ECF9'
    executable = 'Realtek_Audio(v7874)\Setup.exe'
    silentArgs = '/s /sms'
}

Install-CustomPackage $arguments
