$arguments          = @{
    url             = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1355_Mega.exe'
    checksum        = 'BF8AD66CB843665D1E7479C2C6A8CB2BBCEF4B86A767E931729E5F13A3A8BC91'
    silentArgs      = '/VERYSILENT'
}

Install-Package $arguments
