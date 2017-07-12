$arguments          = @{
    url             = 'https://github.com/gitextensions/gitextensions/releases/download/v2.50.01/GitExtensions-2.50.01-SetupComplete.msi'
    checksum        = '54F3726EFD2B07BCD0663E52FB6A57963D879A1B66248F768F4B8A914ADED4E9'
    silentArgs      = '/quiet /norestart'
}

Install-Package $arguments
