$arguments          = @{
    url             = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1415_Mega.exe'
    checksum        = '9DE8CA47907BB90B4AAD1B87B645F1B3B101ACCD4A83BCC07B51CA1F9F35B001'
    silentArgs      = '/VERYSILENT'
}

Install-Package $arguments
