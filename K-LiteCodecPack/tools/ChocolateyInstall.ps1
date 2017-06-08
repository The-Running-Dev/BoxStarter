$arguments          = @{
    url             = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1324_Mega.exe'
    checksum        = 'AE1FCFFC4F5B7ABABB0E0D83E9C6007C140354EB5AB1D8C47061E713A257F6E9'
    silentArgs      = '/VERYSILENT'
}

Install-Package $arguments
