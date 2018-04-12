$arguments = @{
    url        = 'https://release.gitkraken.com/win64/GitKrakenSetup.exe'
    checksum   = '5BB11DB925177CC6F1DD1F8FACB7B74948BB40AFDF1E91A43EB564DDE57A3B0F'
    silentArgs = '-s'
}

Install-Package $arguments
