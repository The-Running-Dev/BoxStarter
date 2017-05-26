$arguments          = @{
    url             = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1316_Mega.exe'
    checksum        = 'B7A8E0009B42FB265A0B7F642A087B57F562671B4549019DF0E05BC5DA094D40'
    silentArgs      = '/VERYSILENT'
}

Install-Package $arguments
