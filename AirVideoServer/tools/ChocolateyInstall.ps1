$arguments          = @{
    url             = 'https://s3.amazonaws.com/AirVideoHD/Download/AirVideoServerHD-2.3.0-beta1.exe'
    checksum        = '99C5A2F1D032040B5D3F2E2637C7936C5BCBE923998FC7C819BD030F4221C53C'
    silentArgs      = '/S'
}

Install-Package $arguments
