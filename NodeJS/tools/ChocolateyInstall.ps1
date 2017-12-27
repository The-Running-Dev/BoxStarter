$arguments      = @{
    url         = 'https://nodejs.org/dist/v9.3.0/node-v9.3.0-x64.msi'
    checksum    = 'FE04C4A19BF6C400C1EA2F984E15F2B1E440D627681BFC97DB92E243D42E5185'
    silentArgs  = '/quiet'
}

Install-Package $arguments

Install-ChocolateyPath "$(Get-ProgramFilesDirectory)\NodeJS" -PathType 'Machine'
