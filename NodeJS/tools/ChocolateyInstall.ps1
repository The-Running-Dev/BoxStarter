$arguments      = @{
    url         = 'https://nodejs.org/dist/v10.0.0/node-v10.0.0-x64.msi'
    checksum    = '1FC52538BFAED268D53146C1DC305C46691C1873EAE0A60ED94D8F5900D4D689'
    silentArgs  = '/quiet'
}

Install-Package $arguments

Install-ChocolateyPath "$(Get-ProgramFilesDirectory)\NodeJS" -PathType 'Machine'
