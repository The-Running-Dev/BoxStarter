$arguments          = @{
    url             = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1365_Mega.exe'
    checksum        = 'B01F80017070CF069DE9A25EF4988DE814E4357E9E79A8993293F1577A4CBE1E'
    silentArgs      = '/VERYSILENT'
}

Install-Package $arguments
