$arguments          = @{
    url             = 'https://download.jetbrains.com/webstorm/WebStorm-2017.3.2.exe'
    checksum        = '5060A762657A7ACE0E808985AC671DD3F332AE036B76564F706E015A4D4C3FF0'
    silentArgs      = '/S'
}

Install-Package $arguments
