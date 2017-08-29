$arguments      = @{
    url         = 'https://nodejs.org/dist/v8.3.0/node-v8.3.0-x64.msi'
    checksum    = 'AF861EB512B58A3625F247E55088BBAF7A6315267AEE6EA998D066961FA57252'
    silentArgs  = '/quiet'
}

Install-Package $arguments

Install-ChocolateyPath "$(Get-ProgramFilesDirectory)\NodeJS" -PathType 'Machine'
