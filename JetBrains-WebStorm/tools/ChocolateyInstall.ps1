$arguments          = @{
    url             = 'https://download.jetbrains.com/webstorm/WebStorm-2017.2.1.exe'
    checksum        = 'F9394D61330E3A38C6FEF8FB799B8908E7CE8ADD105F84C897C4746A6CA11DDD'
    silentArgs      = '/S'
}

Install-Package $arguments
