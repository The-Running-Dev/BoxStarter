$arguments          = @{
    url             = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1375_Mega.exe'
    checksum        = 'CAF68286D2FB66E7F2B857A2F98FDD0A2083ABE822EB1ECB9675CFEEEE065F53'
    silentArgs      = '/VERYSILENT'
}

Install-Package $arguments
