$arguments      = @{
    url         = 'https://nodejs.org/dist/v10.1.0/node-v10.1.0-x64.msi'
    checksum    = '5E8C41ED9F5424EB43DDBB83BEFEDCFDA301CBC26F3BAE88A13811061848D8D1'
    silentArgs  = '/quiet'
}

Install-Package $arguments

Install-ChocolateyPath "$(Get-ProgramFilesDirectory)\NodeJS" -PathType 'Machine'
