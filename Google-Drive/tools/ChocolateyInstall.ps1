$arguments          = @{
    url             = 'https://dl.google.com/drive/gsync_enterprise.msi'
    checksum        = '0AAF710228B96530C02C2FF1A963EA7A41D946CB8AC49125C3F407D49ED8D922'
}

Install-Package $arguments
