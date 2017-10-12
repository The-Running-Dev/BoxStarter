$arguments      = @{
    url         = 'https://nodejs.org/dist/v8.6.0/node-v8.6.0-x64.msi'
    checksum    = 'ACE40C5ECD78183DAAAFF65134A69EB29DE94B5C5D67D81352987D779BE752AD'
    silentArgs  = '/quiet'
}

Install-Package $arguments

Install-ChocolateyPath "$(Get-ProgramFilesDirectory)\NodeJS" -PathType 'Machine'
