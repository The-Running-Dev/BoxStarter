$arguments          = @{
    url             = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1360_Mega.exe'
    checksum        = '7DF154A40B4E552BC35D144B1459B8BA9CD633F0A739E11D6148BB5D4AFAB561'
    silentArgs      = '/VERYSILENT'
}

Install-Package $arguments
