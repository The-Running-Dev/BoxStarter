$arguments      = @{
    url         = 'https://nodejs.org/dist/v7.10.0/node-v7.10.0-x64.msi'
    checksum    = '24A9170BAB2F9F0AFD54B1CA019F249CF30308D682151EB23DCA3918DC6AFFF6'
    silentArgs  = '/quiet'
}

Install-Package $arguments

Install-ChocolateyPath "$(Get-ProgramFilesDirectory)\NodeJS" -PathType 'Machine'