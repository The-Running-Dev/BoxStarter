$arguments          = @{
    url             = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1340_Mega.exe'
    checksum        = '54F72FE0C905FB82500F5C24228BDABE90586FD96A22F8ADA8970E951BB1BD73'
    silentArgs      = '/VERYSILENT'
}

Install-Package $arguments
