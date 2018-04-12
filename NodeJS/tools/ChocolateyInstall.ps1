$arguments      = @{
    url         = 'https://nodejs.org/dist/v9.11.1/node-v9.11.1-x64.msi'
    checksum    = '7298330E75F7C94B94D42B7643F47E9F0EFC32BF54BB07D5B3744410E4816607'
    silentArgs  = '/quiet'
}

Install-Package $arguments

Install-ChocolateyPath "$(Get-ProgramFilesDirectory)\NodeJS" -PathType 'Machine'
