$arguments      = @{
    url         = 'https://nodejs.org/dist/v8.1.0/node-v8.1.0-x64.msi'
    checksum    = '012A874BFECB470875732264A03ACA6760667DBF32D447157FF5669ED862A529'
    silentArgs  = '/quiet'
}

Install-Package $arguments

Install-ChocolateyPath "$(Get-ProgramFilesDirectory)\NodeJS" -PathType 'Machine'
