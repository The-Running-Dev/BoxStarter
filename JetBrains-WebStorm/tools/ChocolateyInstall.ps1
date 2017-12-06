$arguments          = @{
    url             = 'https://download.jetbrains.com/webstorm/WebStorm-2017.3.exe'
    checksum        = '9779A9DF65C78832C91C7CD23678F36E5806D469461F8C6C692C5C4174E9CDEC'
    silentArgs      = '/S'
}

Install-Package $arguments
