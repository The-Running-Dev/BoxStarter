$arguments          = @{
    url             = 'https://download.jetbrains.com/resharper/JetBrains.Rider-2017.3.1.exe'
    checksum        = 'DD7353C121FB5B611194261F8506DE794D63D6A254F773B416E5DD98087B2B8E'
    silentArgs      = '/S'
}

Install-Package $arguments
