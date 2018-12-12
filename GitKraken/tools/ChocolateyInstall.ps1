$arguments = @{
    url        = 'https://release.gitkraken.com/win64/GitKrakenSetup.exe'
    checksum   = '09E19828A270BE815ED35C47DD232AABE0B67D691B0446DE9F15C8AF18D67AF9'
    silentArgs = '-s'
}

Install-Package $arguments
