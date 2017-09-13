$arguments          = @{
    url             = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1350_Mega.exe'
    checksum        = '208D4A79708441067B548ADFD96AB117B79550DB30E9D9CC1C09E3EC8001A9AC'
    silentArgs      = '/VERYSILENT'
}

Install-Package $arguments
