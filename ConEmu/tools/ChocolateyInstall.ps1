$arguments          = @{
    url             = 'https://github.com/Maximus5/ConEmu/releases/download/v17.12.05/ConEmuSetup.171205.exe'
    checksum        = '86008DF96BA2AD69C24985E9EFDCD501AC81409A229E242F15E1ABCDEE491B5F'
    silentArgs      = "/p:x64 /quiet /norestart"
}

Install-Package $arguments
