$arguments          = @{
    url             = 'https://download.jetbrains.com/webstorm/WebStorm-2017.2.5.exe'
    checksum        = '1CFA08AC0DFAEB9C40157DF3B8A25479E80F11E756D836A7836DD5EF7BF598B8'
    silentArgs      = '/S'
}

Install-Package $arguments
