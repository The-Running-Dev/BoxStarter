$arguments      = @{
    url         = 'https://nodejs.org/dist/v8.1.4/node-v8.1.4-x64.msi'
    checksum    = '5A98B1C72BB475E90C8F45AEA171B3C8A778F8D75EAE113301C2B9F234787F9E'
    silentArgs  = '/quiet'
}

Install-Package $arguments

Install-ChocolateyPath "$(Get-ProgramFilesDirectory)\NodeJS" -PathType 'Machine'
