$arguments = @{
    url        = 'https://release.gitkraken.com/win64/GitKrakenSetup.exe'
    checksum   = 'CCB109B78BFA669F3AE25DB2EDC5FB27E96ECA21F9F2EBB7284246069A2A67EA'
    silentArgs = '-s'
}

Install-Package $arguments
