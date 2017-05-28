$arguments          = @{
    url             = 'https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x64.exe'
    checksum        = 'DA66717784C192F1004E856BBCF7B3E13B7BF3EA45932C48E4C9B9A50CA80965'
    silentArgs      = '/Q /norestart'
}

Install-Package $arguments
