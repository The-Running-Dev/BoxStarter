$arguments      = @{
    url         = 'https://nodejs.org/dist/v8.5.0/node-v8.5.0-x64.msi'
    checksum    = 'BC874E741880B873BB0FFAE64ADC0AA34C858E6F7ADABDC26443A2B2E79F7691'
    silentArgs  = '/quiet'
}

Install-Package $arguments

Install-ChocolateyPath "$(Get-ProgramFilesDirectory)\NodeJS" -PathType 'Machine'
