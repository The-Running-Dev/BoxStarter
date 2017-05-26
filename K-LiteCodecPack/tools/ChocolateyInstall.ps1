$arguments          = @{
    url             = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1320_Mega.exe'
    checksum        = '1C5E021BCE8E2905C6658A387614B57291BB5508CC9B048731EC188E9E3E76D1'
    silentArgs      = '/VERYSILENT'
}

Install-Package $arguments
