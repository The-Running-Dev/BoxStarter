$arguments      = @{
    url         = 'https://nodejs.org/dist/v11.4.0/node-v11.4.0-x64.msi'
    checksum    = 'CA494B558C8A8885BEB4DED633B11B6F34A6B903EDA725D156EDB15F8F07A5AD'
    silentArgs  = '/quiet'
}

Install-Package $arguments

Install-ChocolateyPath "$(Get-ProgramFilesDirectory)\NodeJS" -PathType 'Machine'
