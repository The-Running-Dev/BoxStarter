$arguments          = @{
    url             = 'https://github.com/gitextensions/gitextensions/releases/download/v2.51.01/GitExtensions-2.51.01-SetupComplete.msi'
    checksum        = '270A3A67054DC914A08684BFE2E0CF58CB9903A0C3F76530A5688F2BB7FF3DEB'
    silentArgs      = '/quiet /norestart'
}

Install-Package $arguments
