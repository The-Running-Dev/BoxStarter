$arguments      = @{
    url         = 'https://nodejs.org/dist/v9.2.0/node-v9.2.0-x64.msi'
    checksum    = 'EB6C095497F925AAF26E0C82156548A9332EB0805DE9FD700E4F827107572F82'
    silentArgs  = '/quiet'
}

Install-Package $arguments

Install-ChocolateyPath "$(Get-ProgramFilesDirectory)\NodeJS" -PathType 'Machine'
