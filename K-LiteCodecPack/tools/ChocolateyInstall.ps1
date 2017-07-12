$arguments          = @{
    url             = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1333_Mega.exe'
    checksum        = '41E3984AA2DB587C301D56E48310268B610F67905497654F71774B0698976699'
    silentArgs      = '/VERYSILENT'
}

Install-Package $arguments
