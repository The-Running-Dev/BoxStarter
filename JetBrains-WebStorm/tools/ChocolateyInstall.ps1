$arguments          = @{
    url             = 'https://download.jetbrains.com/webstorm/WebStorm-2017.3.1.exe'
    checksum        = '22115139AFEE9BE9B1B525023A110132A0258B3826BC89952E35FFACD91246CF'
    silentArgs      = '/S'
}

Install-Package $arguments
