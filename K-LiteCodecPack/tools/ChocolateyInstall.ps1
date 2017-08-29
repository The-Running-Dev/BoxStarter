$arguments          = @{
    url             = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1345_Mega.exe'
    checksum        = '7C7E4AD89C2D2190991F53FE4338A8F278228E65150E9D4856A6E05FD212DCD0'
    silentArgs      = '/VERYSILENT'
}

Install-Package $arguments
