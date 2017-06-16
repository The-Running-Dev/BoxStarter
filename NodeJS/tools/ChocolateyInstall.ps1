$arguments      = @{
    url         = 'https://nodejs.org/dist/v8.1.2/node-v8.1.2-x64.msi'
    checksum    = 'EAAE7F6C01E8140E6CC12059383BCE3DB7379FF88CA40578BA62A86BDA45B6E8'
    silentArgs  = '/quiet'
}

Install-Package $arguments

Install-ChocolateyPath "$(Get-ProgramFilesDirectory)\NodeJS" -PathType 'Machine'
