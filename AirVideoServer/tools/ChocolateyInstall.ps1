$arguments          = @{
    url             = 'https://s3.amazonaws.com/AirVideoHD/Download/AirVideoServerHD-2.2.4-beta2.exe'
    checksum        = 'DCD5001524B83864F199753FF372BE3A2799827EA8EC0FE6A6C8FBE29F507CF0'
    silentArgs      = '/SD'
}

Install-Package $arguments
