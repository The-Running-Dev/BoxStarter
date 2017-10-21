$arguments      = @{
    url         = 'https://nodejs.org/dist/v8.7.0/node-v8.7.0-x64.msi'
    checksum    = 'FFD191FBDEDB14D2F81E5259E63354EF191CFE845F817004B75A335C4AC54ACC'
    silentArgs  = '/quiet'
}

Install-Package $arguments

Install-ChocolateyPath "$(Get-ProgramFilesDirectory)\NodeJS" -PathType 'Machine'
