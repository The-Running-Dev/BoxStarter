$arguments          = @{
    url             = 'https://download.jetbrains.com/webstorm/WebStorm-2018.1.1.exe'
    checksum        = '3974BF0CEAAEF674B4935361FC3B05895BBF7C8157CDDCED33428E20F05A9226'
    silentArgs      = '/S'
}

Install-Package $arguments
