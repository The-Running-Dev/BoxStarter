$arguments          = @{
    url             = 'https://download.jetbrains.com/webstorm/WebStorm-2017.1.4.exe'
    checksum        = 'AAEE63D4938617CA7AA591BCB4EA8201CBDEAB5E15E409BE994D42C1CA3AB51A'
    silentArgs      = '/S'
}

Install-Package $arguments
