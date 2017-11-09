$arguments      = @{
    url         = 'https://nodejs.org/dist/v8.8.1/node-v8.8.1-x64.msi'
    checksum    = '928BF0C044DB146DF4DD03B388B2117F176A20E49A88CE89EE4AE717EFAE8757'
    silentArgs  = '/quiet'
}

Install-Package $arguments

Install-ChocolateyPath "$(Get-ProgramFilesDirectory)\NodeJS" -PathType 'Machine'
