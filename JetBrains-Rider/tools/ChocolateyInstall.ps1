$arguments          = @{
    url             = 'https://download.jetbrains.com/rider/JetBrains.Rider-2018.1.exe'
    checksum        = '809A71CC1076DDAE2A30768A936FAF18CB0059208EFB4AD83960B57F1F31533A'
    silentArgs      = '/S'
}

Install-Package $arguments
