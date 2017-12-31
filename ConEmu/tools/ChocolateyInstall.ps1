$arguments          = @{
    url             = 'https://github.com/Maximus5/ConEmu/releases/download/v17.12.26/ConEmuSetup.171226.exe'
    checksum        = 'CC447EDA265EED4E1CD0A5C5CBA4E2705ED9B129AFCDA874EDF37373C4DC759E'
    silentArgs      = "/p:x64 /quiet /norestart"
}

Install-Package $arguments
