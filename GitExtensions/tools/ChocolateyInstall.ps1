$arguments          = @{
    url             = 'https://github.com/gitextensions/gitextensions/releases/download/v2.50.02/GitExtensions-2.50.02-SetupComplete.msi'
    checksum        = '1321116C5998A4CE6B87A6C3E7DD7396BD1109D55EF26A3E62D73DD5A3484DCE'
    silentArgs      = '/quiet /norestart'
}

Install-Package $arguments
