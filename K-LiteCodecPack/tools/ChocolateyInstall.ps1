$arguments          = @{
    url             = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1410_Mega.exe'
    checksum        = '82CCF9607A1BB0071489C3760405DA479A35228331D69781B19D1679E018A92E'
    silentArgs      = '/VERYSILENT'
}

Install-Package $arguments
