$arguments      = @{
    url         = 'https://nodejs.org/dist/v8.2.1/node-v8.2.1-x64.msi'
    checksum    = '552AEB03A91A95A1B8E5737BA42FEED670F59E284B463C17AD00EAFA51E31076'
    silentArgs  = '/quiet'
}

Install-Package $arguments

Install-ChocolateyPath "$(Get-ProgramFilesDirectory)\NodeJS" -PathType 'Machine'
