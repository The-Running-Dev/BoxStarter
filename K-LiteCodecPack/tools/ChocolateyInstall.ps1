$arguments          = @{
    url             = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1455_Mega.exe'
    checksum        = '3D472312ADFCE19CC70FE276CD8FC434FF793326D3458B07D6CF309729CF54C5'
    silentArgs      = '/VERYSILENT'
}

Install-Package $arguments
