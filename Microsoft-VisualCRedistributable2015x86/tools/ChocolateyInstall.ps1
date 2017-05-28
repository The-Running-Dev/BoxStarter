$arguments          = @{
    url             = 'https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x86.exe'
    checksum        = '12A69AF8623D70026690BA14139BF3793CC76C865759CAD301B207C1793063ED'
    silentArgs      = '/Q /norestart'
}

Install-Package $arguments
