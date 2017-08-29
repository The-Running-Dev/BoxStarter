$arguments      = @{
    url         = 'https://nodejs.org/dist/v8.4.0/node-v8.4.0-x64.msi'
    checksum    = '8EFBD1B94FF8338BD36A1C30A86ABA4FAE3B80B61E265401FA97E7A4C5478AB2'
    silentArgs  = '/quiet'
}

Install-Package $arguments

Install-ChocolateyPath "$(Get-ProgramFilesDirectory)\NodeJS" -PathType 'Machine'
