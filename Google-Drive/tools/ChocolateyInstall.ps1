$arguments          = @{
    url             = 'https://dl.google.com/drive/gsync_enterprise.msi'
    checksum        = 'D58AA8D090C1CB69EE92ADF656E783A3EB3A5149FBB2B98F23E529D759A5E720'
}

Install-Package $arguments
